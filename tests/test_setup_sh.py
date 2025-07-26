import subprocess
from pathlib import Path

SCRIPT = Path(__file__).resolve().parents[1] / "setup.sh"


def test_setup_test_mode():
    result = subprocess.run(["bash", str(SCRIPT)], env={"TEST_MODE": "1"}, capture_output=True, text=True)
    assert result.returncode == 0
    assert "Detected OS:" in result.stdout
    assert "Test mode: skipping installation." in result.stdout
