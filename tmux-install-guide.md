# Installing tmux from Source

This guide covers installing the latest version of tmux from the GitHub repository.

## Prerequisites

Install all required build dependencies before compiling:

```bash
sudo apt update
sudo apt install -y libevent-dev ncurses-dev build-essential bison pkg-config automake autoconf
```

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/tmux/tmux.git
cd tmux
```

### 2. Build and Install

```bash
sh autogen.sh
./configure
make
sudo make install
```

### 3. Verify Installation

```bash
tmux -V
```

You should see something like `tmux next-3.6` or similar.

### 4. Clean Up Old Sessions (If Needed)

If you encounter errors like "server exited unexpectedly", clean up old socket files:

```bash
tmux kill-server
rm -rf /tmp/tmux-*
```

### 5. Start tmux

```bash
tmux
```

## Troubleshooting

### "open terminal failed: not a terminal"

Check your TERM variable:

```bash
echo $TERM
```

If empty or unusual, set it:

```bash
export TERM=xterm-256color
tmux
```

### "server exited unexpectedly"

This usually means old socket files are causing conflicts:

```bash
rm -rf /tmp/tmux-*
tmux
```

### Verify Compilation Success

Check that dependencies were found during configuration:

```bash
./configure 2>&1 | grep -i term
./configure 2>&1 | grep -i event
```

You should see:
- `checking for LIBEVENT_CORE... yes`
- `checking for LIBTINFO... yes`

## Updating tmux

To update to the latest version:

```bash
cd ~/tmux
git pull
make clean
sh autogen.sh
./configure
make
sudo make install
rm -rf /tmp/tmux-*  # Clean old sockets
```

## Notes

- tmux installs to `/usr/local/bin/tmux` by default
- Old socket files in `/tmp/tmux-*` can cause issues after upgrades
- Always install dependencies before running `./configure`
