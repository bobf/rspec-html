project=rspec-html

.PHONY:
test:
	bundle exec rspec
	bundle exec rubocop
	bundle exec strong_versions
	bundle exec rspec-documentation

.PHONY: publish
publish:
	@RSPEC_DOCUMENTATION_URL_ROOT='/$(project)' bundle exec rspec-documentation
	@rsync --delete -r rspec-documentation/bundle/ docs.bob.frl:/var/www/html/$(project)/
	@echo 'Published.'
