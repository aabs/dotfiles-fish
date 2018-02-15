# init directory

The purpose of this hierarchy of numbered folders (consciously immitating init.d) is to enforce some basic form of ordering on the files being sourced during bootup.

the guarantee is that all `*.fish` files in `rc<n>.d` will have been applied before any of the `*.fish` files in `rc<n+1>.d`. So, if environment vars etc need to be around before scripts make sense, then set them in the prior level of initialisation. 