import os
from pathlib import Path
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt, QUrl, QCoreApplication
import resources_rc

CURRENT_DIR = Path(__file__).resolve().parent
print(CURRENT_DIR)

LIBRARY_DIR = CURRENT_DIR / "qml" 
print(LIBRARY_DIR)

def main():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.addImportPath(os.fspath(LIBRARY_DIR))
    url = QUrl.fromLocalFile(os.fspath(CURRENT_DIR / "main.qml"))
    #engine.load(url)

    def handle_object_created(obj, obj_url):
        if obj is None and url == obj_url:
            QCoreApplication.exit(-1)

    engine.objectCreated.connect(handle_object_created, Qt.ConnectionType.QueuedConnection)
    engine.load(url)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()
