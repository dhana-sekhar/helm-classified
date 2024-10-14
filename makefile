# Define variables

MYRELEASEDEV = my-release-dev
MYRELEASEUAT = my-release-uat
MYRELEASEPROD = my-release-prod

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
.PHONY: clean
clean: uninstalldev uninstalluat uninstallprod

.PHONY: uninstalldev
uninstalldev:
	helm uninstall $(MYRELEASEDEV)

.PHONY: uninstalluat
uninstalluat:
	helm uninstall $(MYRELEASEUAT)

.PHONY: uninstallprod
uninstallprod:
	helm uninstall $(MYRELEASEPROD)
