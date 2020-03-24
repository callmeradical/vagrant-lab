up:
	for i in {0..6}; do (vagrant up "node-$$i" &); done