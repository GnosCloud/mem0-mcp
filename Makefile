include .env

.PHONY: setup-uv

setup-uv:
	@echo "Checking if UV is installed..."
	@powershell -Command "if (Get-Command uv -ErrorAction SilentlyContinue) { \
	    Write-Host 'UV is already installed. Version:' -NoNewline; \
	    uv --version; \
	} else { \
	    Write-Host 'UV not found. Installing UV...'; \
	    pip install uv; \
	    Write-Host 'UV installed successfully. Version:' -NoNewline; \
	    uv --version; \
	}"

# Create virtual environment and install dependencies
setup: setup-uv
	@echo "Setting up the project..."
	uv venv
	@echo "Activating virtual environment and installing dependencies..."
	.venv\Scripts\activate && uv pip install -e .
	@echo ""
	@echo "✅ Setup completed successfully!"
	@echo ""
	@echo "⚠️  IMPORTANT: Please update your Mem0 API key in the .env file"
	@echo "   - Copy .env.example to .env if you haven't already"
	@echo "   - Add your actual MEM0_API_KEY to the .env file"
	@echo "   - Example: MEM0_API_KEY=your-actual-api-key-here"

# Run the application
run:
	@echo "Starting the application on port $(PORT)..."
	uv run main.py --port $(PORT)

# Clean up
clean:
	rm -rf .venv
	help:
	@echo "Available commands:"
	@echo "  make setup-uv    - Check and install UV if not present"
	@echo "  make setup       - Set up the project (create venv and install deps)"
	@echo "  make run         - Run the application"
	@echo "  make clean       - Clean up virtual environment"
	@echo "  make help        - Show this help message"