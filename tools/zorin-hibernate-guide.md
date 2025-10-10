# Zorin OS Hibernate Setup Guide

## Table of Contents
1. [Check Current Hibernate Status](#check-current-hibernate-status)
2. [Verify System Requirements](#verify-system-requirements)
3. [Enable Hibernate](#enable-hibernate)
4. [Test Hibernate](#test-hibernate)
5. [Troubleshooting](#troubleshooting)

---

## Check Current Hibernate Status

### Step 1: Check if Hibernate Command Exists
```bash
systemctl hibernate
```
**Expected Results:**
- If hibernate works: System will hibernate immediately
- If not enabled: Error message like "Failed to hibernate system via logind"

### Step 2: Check Available Power Management Options
```bash
cat /sys/power/state
```
**Expected Output:** Should show `freeze mem disk`
- `disk` = hibernate is supported by kernel

### Step 3: Check Systemd Hibernate Status
```bash
systemctl status systemd-hibernate.service
```
Shows whether the hibernate service is loaded and available.

---

## Verify System Requirements

### Step 1: Check RAM Size
```bash
free -h
```
**Important:** Your swap partition must be **at least equal to or larger than your RAM** for hibernate to work reliably.

### Step 2: Verify Swap Partition
```bash
swapon --show
```
**Expected Output:** Should show your swap partition is active
```
NAME           TYPE SIZE USED
/dev/nvme0n1p3 partition 8G 0B
```

### Step 3: Get Swap Partition UUID
```bash
sudo blkid | grep swap
```
**Example Output:**
```
/dev/nvme0n1p3: UUID="1234abcd-5678-efgh-90ij-klmnopqrstuv" TYPE="swap"
```
**📝 IMPORTANT: Copy this UUID - you'll need it later!**

### Step 4: Alternative - Use Device Path
```bash
lsblk -f | grep swap
```
This confirms your swap partition location (should be `/dev/nvme0n1p3` based on your layout).

---

## Enable Hibernate

### Step 1: Configure GRUB with Resume Parameter

Edit the GRUB configuration:
```bash
sudo nano /etc/default/grub
```

Find the line that starts with:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
```

**Option A: Using UUID (Recommended)**
Change it to:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=YOUR-SWAP-UUID-HERE"
```

**Option B: Using Device Path (Your Previous Method)**
Change it to:
```
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=/dev/nvme0n1p3"
```

**⚠️ CRITICAL NOTE:** 
- Use **nvme0n1p3** (your 8GB swap partition)
- NOT nvme0n1p6 (that's your /stuff partition)
- Using the wrong partition will prevent hibernate from working

**Save and exit:** `Ctrl+O`, `Enter`, `Ctrl+X`

### Step 2: Update GRUB
```bash
sudo update-grub
```

### Step 3: Configure Initramfs Resume

Create or edit the resume configuration:
```bash
sudo nano /etc/initramfs-tools/conf.d/resume
```

Add this line (using your swap UUID):
```
RESUME=UUID=YOUR-SWAP-UUID-HERE
```

Or using device path:
```
RESUME=/dev/nvme0n1p3
```

**Save and exit:** `Ctrl+O`, `Enter`, `Ctrl+X`

### Step 4: Update Initramfs
```bash
sudo update-initramfs -u -k all
```

### Step 5: Enable Hibernate in Systemd (Optional but Recommended)

Check if hibernate is blocked:
```bash
cat /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla
```

If file doesn't exist, create it:
```bash
sudo nano /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla
```

Add this content:
```ini
[Re-enable hibernate by default in upower]
Identity=unix-user:*
Action=org.freedesktop.upower.hibernate
ResultActive=yes

[Re-enable hibernate by default in logind]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1.hibernate-multiple-sessions;org.freedesktop.login1.hibernate-ignore-inhibit
ResultActive=yes
```

**Save and exit:** `Ctrl+O`, `Enter`, `Ctrl+X`

### Step 6: Reboot
```bash
sudo reboot
```

---

## Test Hibernate

### Method 1: Command Line Test
```bash
systemctl hibernate
```
System should hibernate. Press power button to wake.

### Method 2: Check Hibernate Option in GUI
After reboot, check if hibernate appears in:
- Power menu
- System settings → Power options

### Method 3: Verify Resume Parameter Loaded
```bash
cat /proc/cmdline
```
Should show `resume=/dev/nvme0n1p3` or `resume=UUID=...` in the output.

---

## Troubleshooting

### Issue: Hibernate Command Fails

**Check kernel parameters are loaded:**
```bash
cat /proc/cmdline | grep resume
```
If `resume=` doesn't appear, GRUB wasn't updated properly.

**Solution:** Re-run Step 2 from Enable Hibernate section:
```bash
sudo update-grub
sudo reboot
```

### Issue: System Hibernates but Won't Resume

**Possible Cause:** Wrong resume device specified

**Verify your swap partition:**
```bash
swapon --show
cat /proc/swaps
```

**Check resume configuration:**
```bash
cat /etc/initramfs-tools/conf.d/resume
```

**Solution:** Ensure it points to your actual swap partition (nvme0n1p3), then:
```bash
sudo update-initramfs -u -k all
sudo reboot
```

### Issue: Not Enough Swap Space

**Check if swap is smaller than RAM:**
```bash
free -h
```

**Solution:** If RAM > Swap, you need to either:
1. Increase swap partition size (requires repartitioning)
2. Add a swap file to supplement the partition

### Check System Logs After Failed Hibernate
```bash
journalctl -b -1 | grep -i hibernate
```
Shows hibernate-related messages from last boot.

```bash
journalctl -b -1 | grep -i resume
```
Shows resume-related messages from last boot.

### Verify Hibernate is Not Blocked by BIOS

Some systems have hibernate disabled in BIOS/UEFI:
1. Reboot into BIOS/UEFI settings
2. Look for power management options
3. Ensure "S4 State" or "Hibernate" is enabled

---

## Quick Reference Commands

```bash
# Check hibernate support
cat /sys/power/state

# Show swap
swapon --show

# Get swap UUID
sudo blkid | grep swap

# Test hibernate
systemctl hibernate

# Check if resume parameter is loaded
cat /proc/cmdline | grep resume

# View hibernate logs
journalctl -b -1 | grep -i hibernate
```

---

## Important Notes

✅ **Your Partition Layout:**
- Swap: `/dev/nvme0n1p3` (8GB)
- This is what should be used for `resume=` parameter

❌ **Common Mistake:**
- Using `/dev/nvme0n1p6` (your /stuff partition) will NOT work
- Previous success might have been due to other factors

💡 **Best Practice:**
- Use UUID instead of device path (/dev/...) for more reliable resume
- UUIDs don't change even if drive order changes

⚠️ **Secure Boot:**
- Some systems with Secure Boot may have issues with hibernate
- If problems persist, check BIOS/UEFI secure boot settings

---

*Last Updated: October 2025*