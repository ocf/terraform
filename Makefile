TF_VERSION := 0.14.6
TF_ZIP_FILE = terraform_${TF_VERSION}_linux_amd64.zip
TF_CHECKSUMS_FILE = terraform_${TF_VERSION}_SHA256SUMS
TF_CHECKSUMS_SIG_FILE = $(TF_CHECKSUMS_FILE).sig
BASE_URL = https://releases.hashicorp.com/terraform/${TF_VERSION}
REPO_ROOT = $(shell git rev-parse --show-toplevel)
TF_PATH = $(REPO_ROOT)/bin/terraform

venv:
	# Try to use python3.7 if it's available (on OCF machines for instance),
	# otherwise fall back to using whatever python3 version is around (GitHub
	# Actions for instance)
	python3.7 -m venv venv || python3 -m venv venv
	$(REPO_ROOT)/venv/bin/pip install pre-commit

.PHONY: install-hooks
install-hooks: venv
	$(REPO_ROOT)/venv/bin/pre-commit install -f --install-hooks

.PHONY: test
test: venv install-hooks bin/terraform
	$(REPO_ROOT)/venv/bin/pre-commit run --all-files

# Set up the terraform binary, with some validation to make sure it's trusted
# and contains the contents that Hashicorp has made checksums for.
# Alternatively, it could be included directly in this repo, but it's large
# enough (as of v0.12.29, 67 MB) that it's not included and is instead
# set up as needed.
bin/terraform:
	# Import the Hashicorp GPG key to validate the checksums
	gpg --keyserver keyserver.ubuntu.com --recv-keys 91A6E7F85D05C65630BEF18951852D87348FFC4C

	# Download the zip file with the terraform binary, the checksums, and the
	# checksum signature file
	wget -q $(BASE_URL)/$(TF_CHECKSUMS_FILE) -O bin/$(TF_CHECKSUMS_FILE)
	wget -q $(BASE_URL)/$(TF_CHECKSUMS_SIG_FILE) -O bin/$(TF_CHECKSUMS_SIG_FILE)
	wget -q $(BASE_URL)/$(TF_ZIP_FILE) -O bin/$(TF_ZIP_FILE)

	# Verify the checksums file is untampered by using the signature
	gpg --verify bin/$(TF_CHECKSUMS_SIG_FILE) bin/$(TF_CHECKSUMS_FILE)

	# Verify the checksum matches the downloaded zip file
	cd bin/ && sha256sum --ignore-missing -c $(TF_CHECKSUMS_FILE)

	# Extract the zip file to get the terraform binary
	unzip bin/$(TF_ZIP_FILE) -d bin/

	# Clean up any remaining downloaded files
	rm bin/$(TF_CHECKSUMS_FILE) bin/$(TF_CHECKSUMS_SIG_FILE) bin/$(TF_ZIP_FILE)


.PHONY: plan
plan: bin/terraform
	$(foreach project, $(wildcard $(REPO_ROOT)/projects/*), echo $(project) && cd $(project) && $(TF_PATH) init && $(TF_PATH) plan;)

.PHONY: plan
auto-plan: bin/terraform
	$(foreach project, $(wildcard $(REPO_ROOT)/projects/*), ./bin/autoplan-project $(TF_PATH) $(project);)

.PHONY: apply
apply: bin/terraform
	$(foreach project, $(wildcard $(REPO_ROOT)/projects/*), echo $(project) && cd $(project) && $(TF_PATH) init && $(TF_PATH) apply;)

.PHONY: auto-apply
auto-apply: bin/terraform
	# Don't do this unless you know what you're doing, there's no confirmation before actually applying any changes!
	$(foreach project, $(wildcard $(REPO_ROOT)/projects/*), echo $(project) && cd $(project) && $(TF_PATH) init && $(TF_PATH) apply -auto-approve;)
