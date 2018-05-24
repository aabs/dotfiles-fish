release_tag=0.0.2_alpha
release_contents=bin init editors tools bootstrap.fish indirection.fish install.fish known-plugins.dat profile.symlink README.org
release:
	echo "$(release_tag)" > latest_release.txt
	git add -A .
	git commit -m "release $(release_tag) checkin"
	git tag -f $(release_tag)
	git push --all --tags --atomic 
	tar czvf fishdots-$(release_tag).tar.gz $(release_contents)
	hub create -p -a fishdots-$(release_tag).tar.gz -m "Release $(release_tag)" $(release_tag)