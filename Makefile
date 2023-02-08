local:
	@hugo server --buildDrafts --buildFuture --disableFastRender --watch --verbose

deploy:
	@hugo --minify --verbose
	@cd public && git add --all && git commit -m "update" && git push
