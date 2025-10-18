#!/bin/bash

# ===== Portfolio CV Setup Script =====
# Cross-platform setup for Windows (Git Bash), Mac, and Linux
# This script interactively configures your portfolio with personal details

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LAYOUT_FILE="$SCRIPT_DIR/layouts/index.html"
BACKUP_FILE="$SCRIPT_DIR/layouts/index.html.backup.$(date +%s)"

echo -e "${MAGENTA}"
echo "╔════════════════════════════════════╗"
echo "║  🎮 Portfolio CV Setup Script 🎮  ║"
echo "║  Cross-platform Configuration      ║"
echo "╚════════════════════════════════════╝"
echo -e "${NC}"

# Backup original file
echo -e "${CYAN}📋 Creating backup...${NC}"
cp "$LAYOUT_FILE" "$BACKUP_FILE"
echo -e "${GREEN}✓ Backup created: $BACKUP_FILE${NC}"

# Initialize variables
FULL_NAME=""
EMAIL=""
DOMAIN=""
GITHUB_USER=""
TWITTER_HANDLE=""
LINKEDIN_PROFILE=""

# Function to prompt user with default
prompt_user() {
    local prompt_text=$1
    local default_value=$2
    local input_value=""
    
    read -p "$(echo -e ${BLUE})$prompt_text$(echo -e ${NC}) [$default_value]: " input_value
    
    if [ -z "$input_value" ]; then
        echo "$default_value"
    else
        echo "$input_value"
    fi
}

# Function to validate email
validate_email() {
    local email=$1
    if [[ $email =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to validate domain
validate_domain() {
    local domain=$1
    if [[ $domain =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*(\.[a-zA-Z]{2,})?$ ]]; then
        return 0
    else
        return 1
    fi
}

echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}Personal Information${NC}"
echo -e "${YELLOW}(Press Enter to skip a field)${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Full Name
while true; do
    FULL_NAME=$(prompt_user "👤 Full Name" "YOUR NAME HERE")
    if [ -z "$FULL_NAME" ] || [ "$FULL_NAME" = "YOUR NAME HERE" ]; then
        break
    elif [ ${#FULL_NAME} -lt 2 ]; then
        echo -e "${RED}✗ Name must be at least 2 characters${NC}"
    else
        break
    fi
done

# Email
while true; do
    EMAIL=$(prompt_user "📧 Email Address" "your@email.com")
    if [ "$EMAIL" = "your@email.com" ] || [ -z "$EMAIL" ]; then
        break
    elif validate_email "$EMAIL"; then
        break
    else
        echo -e "${RED}✗ Invalid email format${NC}"
    fi
done

# Domain
while true; do
    DOMAIN=$(prompt_user "🌐 Domain/Website" "yourdomain.com")
    if [ "$DOMAIN" = "yourdomain.com" ] || [ -z "$DOMAIN" ]; then
        break
    elif validate_domain "$DOMAIN"; then
        break
    else
        echo -e "${RED}✗ Invalid domain format${NC}"
    fi
done

echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}Social Media Profiles${NC}"
echo -e "${YELLOW}(Optional - press Enter to skip)${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# GitHub
GITHUB_USER=$(prompt_user "🐙 GitHub username" "yourprofile")
if [ -z "$GITHUB_USER" ]; then
    GITHUB_USER="yourprofile"
fi

# Twitter
TWITTER_HANDLE=$(prompt_user "𝕏 Twitter/X handle" "yourhandle")
if [ -z "$TWITTER_HANDLE" ]; then
    TWITTER_HANDLE="yourhandle"
fi

# LinkedIn
LINKEDIN_PROFILE=$(prompt_user "💼 LinkedIn profile" "yourprofile")
if [ -z "$LINKEDIN_PROFILE" ]; then
    LINKEDIN_PROFILE="yourprofile"
fi

echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}📝 Summary of Changes:${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "${CYAN}Name:${NC}              $FULL_NAME"
echo -e "${CYAN}Email:${NC}             $EMAIL"
echo -e "${CYAN}Domain:${NC}            $DOMAIN"
echo -e "${CYAN}GitHub:${NC}            $GITHUB_USER"
echo -e "${CYAN}Twitter:${NC}           $TWITTER_HANDLE"
echo -e "${CYAN}LinkedIn:${NC}          $LINKEDIN_PROFILE"

echo ""
read -p "$(echo -e ${YELLOW})Proceed with updates? (y/n): ${NC}" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}✗ Setup cancelled${NC}"
    rm "$BACKUP_FILE"
    exit 1
fi

echo -e "${CYAN}🔄 Updating files...${NC}"

# Replace placeholders in the file
# Create a temporary file for replacements
TEMP_FILE="$SCRIPT_DIR/layouts/index.html.tmp"
cp "$LAYOUT_FILE" "$TEMP_FILE"

# Perform replacements
sed -i.bak \
    -e "s/YOUR NAME HERE/$FULL_NAME/g" \
    -e "s/your@email.com/$EMAIL/g" \
    -e "s|yourdomain.com|$DOMAIN|g" \
    -e "s/yourprofile/$GITHUB_USER/g" \
    -e "s/yourhandle/$TWITTER_HANDLE/g" \
    -e "s/Portfolio Owner/$FULL_NAME/g" \
    "$TEMP_FILE"

# Handle macOS's sed (which creates a backup)
if [ -f "$TEMP_FILE.bak" ]; then
    rm "$TEMP_FILE.bak"
fi

# Replace the original file
mv "$TEMP_FILE" "$LAYOUT_FILE"

# Remove old backup from sed
if [ -f "$LAYOUT_FILE.bak" ]; then
    rm "$LAYOUT_FILE.bak"
fi

echo -e "${GREEN}✓ File updated successfully${NC}"

# Rebuild Hugo
echo -e "${CYAN}🔨 Rebuilding Hugo site...${NC}"
if command -v hugo &> /dev/null; then
    cd "$SCRIPT_DIR"
    hugo 2>&1 | grep -E "(Total|Pages|error)" || true
    echo -e "${GREEN}✓ Build complete${NC}"
else
    echo -e "${YELLOW}⚠ Hugo not found in PATH${NC}"
    echo -e "${CYAN}Install Hugo from: https://gohugo.io/installation/${NC}"
fi

echo ""
echo -e "${MAGENTA}╔════════════════════════════════════╗${NC}"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo -e "${MAGENTA}╚════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Next steps:${NC}"
echo -e "  1. Start dev server: ${YELLOW}hugo server${NC}"
echo -e "  2. Visit: ${YELLOW}http://localhost:1313${NC}"
echo -e "  3. Review and customize content in ${YELLOW}layouts/index.html${NC}"
echo -e "  4. Update social links and domain everywhere${NC}"
echo ""
echo -e "${CYAN}Backup saved at:${NC} $BACKUP_FILE"
echo ""
echo -e "${GREEN}Happy building! 🎮${NC}"
