import os
from pathlib import Path
import sys
import pandas as pd

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Qt, QUrl, QCoreApplication, QAbstractTableModel, QModelIndex
from PySide6.QtSql import QSqlDatabase, QSqlQueryModel
import resources_rc

CURRENT_DIR = Path(__file__).resolve().parent
LIBRARY_DIR = CURRENT_DIR / "qml" 

class CompaniesModel(QSqlQueryModel):
    def __init__(self):
        super().__init__()
        self.setQuery("SELECT * FROM companies")

class PandasModel(QAbstractTableModel):
    def __init__(self, data):
        super().__init__()
        self._data = data

    def rowCount(self, parent=QModelIndex()):
        return self._data.shape[0]

    def columnCount(self, parent=QModelIndex()):
        return self._data.shape[1]

    def data(self, index, role):
        if role == Qt.DisplayRole:
            value = self._data.iloc[index.row(), index.column()]
            return str(value)
        return None

    def headerData(self, section, orientation, role):
        if role == Qt.DisplayRole:
            if orientation == Qt.Horizontal:
                return str(self._data.columns[section])
            if orientation == Qt.Vertical:
                return str(self._data.index[section])
        return None



def main():
    app = QGuiApplication(sys.argv)

    # Load data from CSV
    df = pd.read_csv("companies_data.csv")

    # Create and expose the model
    companies_model = PandasModel(df)

    # Set up the database connection
    #db = QSqlDatabase.addDatabase("QSQLITE")
    #db.setDatabaseName("placeholder")
    #if not db.open():
    #     print("Error: connection with the database failed.")
    #     sys.exit(-1)
    
    # Create and expose the model  
    #companies_model = CompaniesModel()
    
    engine = QQmlApplicationEngine()
    engine.addImportPath(os.fspath(LIBRARY_DIR))
    engine.rootContext().setContextProperty("companiesModel", companies_model)
    #engine.rootContext().setContextProperty("companiesModel", CompaniesModel)
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
