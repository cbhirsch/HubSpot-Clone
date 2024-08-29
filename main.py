import sys
from pathlib import Path
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QDir
import resources_rc

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Add the current directory to the QML import path
    current_dir = QDir.currentPath()
    engine.addImportPath(current_dir)

    # Print the import paths for debugging
    print("QML Import Paths:", engine.importPathList())

    qml_file = Path(__file__).resolve().parent / "main.qml"
    
    engine.load(qml_file)
    if not engine.rootObjects():
        print("Failed to load QML file")
        sys.exit(-1)
    sys.exit(app.exec())
