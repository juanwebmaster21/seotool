#!/bin/bash
set -e

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ❌ Error: $1" >&2
    exit 1
}

# Ensure we're in the correct directory
ensure_correct_directory() {
    log "📂 Ensuring correct directory..."

    # Define the expected directory
    EXPECTED_DIR="$HOME/seoenv/merged_seo"

    # Check if we're in the expected directory
    if [ "$(pwd)" != "$EXPECTED_DIR" ]; then
        log "Changing to the correct directory: $EXPECTED_DIR"
        cd "$EXPECTED_DIR" || error "Failed to change to the correct directory"
    fi
}

# Set up GitHub Actions for CI/CD
setup_github_actions() {
    log "🔧 Setting up GitHub Actions for CI/CD..."

    # Create the GitHub Actions workflow directory
    mkdir -p .github/workflows

    # Create the CI workflow file
    cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.8'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Run tests
      run: |
        pytest tests
EOF

    log "✅ GitHub Actions setup complete!"
}

# Set up unit testing
setup_unit_testing() {
    log "🧪 Setting up unit testing..."

    # Create the tests directory
    mkdir -p tests

    # Create a sample test file
    cat > tests/test_sample.py << 'EOF'
def test_example():
    assert True
EOF

    log "✅ Unit testing setup complete!"
}

# Main function
main() {
    log "🚀 Starting CI/CD and testing setup..."

    ensure_correct_directory
    setup_github_actions
    setup_unit_testing

    log "✅ CI/CD and testing setup completed successfully!"
}

# Run main function
main 