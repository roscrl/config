#!/bin/zsh

TMP_DIR=$(mktemp -d -t macos_defaults_diff_XXXXXX)

# Check if mktemp failed
if [[ -z "$TMP_DIR" || ! -d "$TMP_DIR" ]]; then
  echo "Error: Could not create temporary directory." >&2
  exit 1
fi

# Define file paths within the temporary directory
BEFORE_FILE="$TMP_DIR/defaults_before.txt"
AFTER_FILE="$TMP_DIR/defaults_after.txt"

# --- Functions ---
echo ">>> Step 1: Capturing current 'defaults read' output..."
defaults read > "$BEFORE_FILE"
echo "   Saved initial state to $BEFORE_FILE" # Useful confirmation

echo "\n>>> Step 2: Please make the desired change in macOS System Settings now."

# Pause and wait for the user to press Enter
# The '?prompt' is a zsh feature for read prompts
read "?>>> Press ENTER when you are ready to capture the new settings... "

echo "\n>>> Step 3: Capturing 'defaults read' output after the change..."
defaults read > "$AFTER_FILE"
echo "   Saved final state to $AFTER_FILE"

echo "\n>>> Step 4: Calculating and displaying differences..."
echo "-----------------------------------------------------"
# Use diff to compare the files.
# Consider `diff -u` for a unified format which is often clearer.
diff -u "$BEFORE_FILE" "$AFTER_FILE"

exit 0
