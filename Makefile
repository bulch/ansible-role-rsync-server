########
# Molecule
########

create:
	molecule --debug create

list:
	molecule list

converge:
	molecule converge

test:
	molecule --debug test --all

destroy:
	molecule destroy --all

verify:
	molecule verify

login:
	molecule login

########
# Rsync
########

RSYNC_STORAGE=example-storage
RSYNC_LOGIN=9D0EeojsHCU
RSYNC_PASSWORD=068tg5jLVv4
RSYNC_PORT=873

# RSYNC_PASSWORD=068tg5jLVv4 rsync --list-only rsync://9D0EeojsHCU@localhost:873/example-storage

rsync-list:
	RSYNC_PASSWORD=${RSYNC_PASSWORD} rsync --list-only rsync://${RSYNC_LOGIN}@localhost:${RSYNC_PORT}/${RSYNC_STORAGE}

rsync-copy:
	RSYNC_PASSWORD=${RSYNC_PASSWORD} rsync -rca README.md rsync://${RSYNC_LOGIN}@localhost:${RSYNC_PORT}/${RSYNC_STORAGE}

########
# Develop
########

lint: yamllint ansible-lint

yamllint:
	yamllint .

ansible-lint:
	ansible-lint .
