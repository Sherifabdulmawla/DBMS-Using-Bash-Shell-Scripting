mkdir DBMS 2>>> ./error.log
clear
function mainMenu() {
  echo -e "\n\n+-------------------------------+"
  echo "| 1. Select DB                  |"
  echo "| 2. Create DB                  |"
  echo "| 3. Rename DB                  |"
  echo "| 4. Drop DB                    |"
  echo "| 5. Show DBs                   |"
  echo "| 6. Exit                       |"
  echo "+-------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  selectDB ;;
    2)  createDB ;;
    3)  renameDB ;;
    4)  dropDB ;;
    5)  ls ./DBMS ; mainMenu;;
    6) exit ;;
    *) echo " Wrong Choice " ; mainMenu;
  esac
}

function selectDB {
  echo -e "Enter Database Name: \c"
  read dbName
  cd ./DBMS/$dbName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "$dbName was Successfully Selected"
    tablesMenu
  else
    echo "Database $dbName wasn't found"
      mainMenu

  fi
}

function createDB {
  echo -e "Enter Database Name: \c"
  read dbName
  mkdir ./DBMS/$dbName
  if [[ $? == 0 ]] 
  then
    echo "Database Created Successfully"
  else
    echo "Error Creating Database $dbName"
  fi
  mainMenu
}

function renameDB {
  echo -e "Enter Current Database Name: \c"
  read dbName
  echo -e "Enter New Database Name: \c"
  read newName
  mv ./DBMS/$dbName ./DBMS/$newName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "Database Renamed Successfully"
  else
    echo "Error Renaming Database"
  fi
  mainMenu
}


function dropDB {
  echo -e "Enter Database Name: \c"
  read dbName
  rm -r ./DBMS/$dbName 2>>./error.log
  if [[ $? == 0 ]]; then
    echo "Database Dropped Successfully"
  else
    echo "Database Not found"
  fi
  mainMenu
}

function tablesMenu {
  echo -e "\n\n+-------------------------------+"
  echo "| 1. Create New Table           |"
  echo "| 2. Insert Into Table          |"
  echo "| 3. Select From Table          |"
  echo "| 4. Update Table               |"
  echo "| 5. Delete From Table          |"
  echo "| 6. Drop Table                 |"
  echo "| 7. Back To Main Menu          |"
  echo "| 8. Exit                       |"
  echo "+-------------------------------+"
  echo -e "Enter Choice: \c"
  read ch
  case $ch in
    1)  createTable ;;
    2)  ;;
    3)  ;;
    4)  ;;
    5)  ;;
    6)  ;;
    7) clear; mainMenu ;;
    8) exit ;;
    *) echo " Wrong Choice " ; mainMenu;
  esac
  
}

function createTable {
  echo -e "Enter Table Name \c"
  read tableName
  echo -e "Enter Number of Columns \c"
  read colsNum
  counter=1
  seperator="|"
    while [ $counter -le $colsNum ]
    do
     echo -e "Enter Name of Column Number $counter:\c"
     read colName
     temp=$temp$colName$seperator
     ((counter++))
    done
    touch $tableName
    echo -e $temp >> $tableName
  if [[ $? == 0 ]] 
  then
    echo "Table Created Successfully"
  else
    echo "Error Creating Table $tableName"
  fi
  tablesMenu
}

mainMenu

