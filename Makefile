release_tag=0.0.5
release_contents=bin init editors tools bootstrap.fish indirection.fish install.fish known-plugins.dat profile.symlink README.org

.PHONY: release

release:
	echo "$(release_tag)" > latest_release.txt
	git add -A .
	git commit -m "release $(release_tag) checkin"
	git tag -f $(release_tag)
	git push --all --tags --atomic 

prep:
	mkdir -p ~/tmp/fishdots_test


clean:
	@rm -rf ~/.config/fishdots
	@rm -f ~/.config/fish/config.*
	@rm -rf ~/tmp/fishdots_test