local:
	@hugo server --buildDrafts --buildFuture --disableFastRender --watch --verbose

deploy:
	@hugo --minify --verbose
	@cd public && \
		git remote set-url origin git@github.com:klee1611/klee1611.github.io && \
		git add --all && git commit -m "update" && git push
