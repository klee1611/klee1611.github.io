local:
	@hugo server --buildDrafts --buildFuture --disableFastRender --watch --verbose

deploy:
	@hugo --minify --cleanDestinationDir --verbose
	@cd public && git add --all && git commit -m "update" && git push origin master
