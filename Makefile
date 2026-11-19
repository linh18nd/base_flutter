# Common commands. Run `make` (or `make help`) to list them.
# Everything goes through fvm so the pinned Flutter version is always used.

FVM     ?= fvm
FLUTTER := $(FVM) flutter
DART    := $(FVM) dart
MASON   := $(DART) pub global run mason_cli:mason
FLAVOR  ?= dev
ENV_FILE = env/$(FLAVOR).json
# Hand-written Dart files only; generated code keeps its generator's format.
SRC_FILES = $(shell find lib test -name '*.dart' ! -path 'lib/i18n/gen/*' \
	! -name '*.g.dart' ! -name '*.freezed.dart')

.DEFAULT_GOAL := help
.PHONY: help setup gen watch run test analyze format check feature shared clean

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-9s\033[0m %s\n", $$1, $$2}'

setup: ## First-time setup: Flutter, packages, mason bricks, generated code
	$(FVM) install
	$(FLUTTER) pub get
	$(DART) pub global activate mason_cli
	$(MASON) get
	$(MAKE) gen

gen: ## Generate code (slang translations + build_runner)
	$(DART) run slang
	$(DART) run build_runner build

watch: ## Regenerate build_runner code on every file change
	$(DART) run build_runner watch

run: ## Run the app: make run [FLAVOR=dev|stag|prod]
	$(FLUTTER) run --flavor $(FLAVOR) \
		$(if $(wildcard $(ENV_FILE)),--dart-define-from-file=$(ENV_FILE),)

test: ## Run all tests
	$(FLUTTER) test

analyze: ## Static analysis
	$(FLUTTER) analyze

format: ## Format hand-written code in lib/ and test/
	$(DART) format $(SRC_FILES)

check: ## Run before committing: format check, analyze, test
	$(DART) format --output=none --set-exit-if-changed $(SRC_FILES)
	$(FLUTTER) analyze
	$(FLUTTER) test

feature: ## Scaffold a feature: make feature name=orders entity=order
	@if [ -z "$(name)" ] || [ -z "$(entity)" ]; then \
		echo "Usage: make feature name=orders entity=order"; exit 1; fi
	$(MASON) make feature --feature $(name) --entity $(entity)
	$(MAKE) gen
	$(DART) format $$(find lib/features/$(name) test/features/$(name) \
		-name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart')
	@echo ""
	@echo "Next steps:"
	@echo "  1. Call register<Name>Feature(getIt) in lib/app/di/injection.dart"
	@echo "  2. Add a route in lib/app/router/routes.dart and app_router.dart"
	@echo "  3. Replace the sample fields/endpoint marked TODO(team)"

shared: ## Scaffold a shared module: make shared name=users entity=user
	@if [ -z "$(name)" ] || [ -z "$(entity)" ]; then \
		echo "Usage: make shared name=users entity=user"; exit 1; fi
	$(MASON) make shared --module $(name) --entity $(entity)
	$(MAKE) gen
	$(DART) format $$(find lib/shared/$(name) test/shared/$(name) \
		-name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart')
	@echo ""
	@echo "Next steps:"
	@echo "  1. Call register<Name>Module(getIt) in lib/app/di/injection.dart,"
	@echo "     before the features that use it"
	@echo "  2. Replace the sample fields/endpoint marked TODO(team)"
	@echo "  3. Import it from features: package:base_flutter/shared/$(name)/..."

clean: ## Remove build outputs and caches
	$(FLUTTER) clean
	rm -rf .mason
