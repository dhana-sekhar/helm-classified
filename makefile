# Define variables

MYRELEASEDEV = my-release-dev
MYRELEASEUAT = my-release-uat
MYRELEASEPROD = my-release-prod
PYTHON=python3
FLAKE8=flake8
PYTEST=pytest
PYLINT=pylint
SRC=src
TESTS=tests
DOCKER_IMAGE=sekharbuddha/gitactions:latest

# Run both pytest and flake8
.PHONY: all
all: lint test build clean

# Lint code using flake8
.PHONY: lint
lint:
	$(FLAKE8) $(SRC) $(TESTS)
	$(PYLINT) .

# Run tests using pytest
.PHONY: test
test:
	$(PYTEST) $(TESTS)

# Build step (customize as needed)
.PHONY: build
build:
	@echo "Building the project..."
	@echo "Login to Docker"
	docker login
	@echo "Login successful"
	docker build -t $(DOCKER_IMAGE) .
	docker images |grep gitaction
	docker push $(DOCKER_IMAGE)
	@echo "Build successful!"

# Clean up temporary files (optional)
.PHONY: clean
clean:
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete

# Install dependencies
.PHONY: install
install:
	$(PYTHON) -m pip install -r requirements.txt


.PHONY: runall
runall: dev uat prod

.PHONY: dev
dev: 
	helm install $(MYRELEASEDEV) ./myfirstchart -f ./myfirstchart/values-dev.yaml

.PHONY: uat
uat: 
	helm install $(MYRELEASEUAT) ./myfirstchart -f ./myfirstchart/values-uat.yaml

.PHONY: prod
prod: 
	helm install $(MYRELEASEPROD) ./myfirstchart -f ./myfirstchart/values-prod.yaml

.PHONY: upgradeall
runall: upgradedev upgradeuat upgradeprod

.PHONY: upgradedev
upgradedev: 
	helm upgrade $(MYRELEASEDEV) ./myfirstchart -f ./myfirstchart/values-dev.yaml

.PHONY: upgradeuat
upgradeuat: 
	helm upgrade $(MYRELEASEUAT) ./myfirstchart -f ./myfirstchart/values-uat.yaml

.PHONY: upgradeprod
upgradeprod: 
	helm upgrade $(MYRELEASEPROD) ./myfirstchart -f ./myfirstchart/values-prod.yaml


# Uninstall all releases
.PHONY: cleanall
cleanall: uninstalldev uninstalluat uninstallprod

.PHONY: uninstalldev
uninstalldev:
	helm uninstall $(MYRELEASEDEV)

.PHONY: uninstalluat
uninstalluat:
	helm uninstall $(MYRELEASEUAT)

.PHONY: uninstallprod
uninstallprod:
	helm uninstall $(MYRELEASEPROD)
