#!/bin/bash
# Function to check if the address book file exists
fileExists(){
 if [ ! -e Address_Book.txt ]; then
 return 1
 else
 return 0
 fi
}
# Function to create the address book file
createAddressBook(){
 if fileExists; then
 echo "Address Book already exists."
 else
 touch Address_Book.txt
 echo "ID | Name | Email | Phone Number | Address | Blood Group | 
Age | Weight | Gender |" > Address_Book.txt
 fi
}
# Function to view the address book
viewAddressBook(){
 if fileExists; then
 if [ -s Address_Book.txt ]; then # -s to check if file 
exists and is non-empty
 cat Address_Book.txt
 else
 echo "Address Book is Empty"
 fi
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
# Function to insert a record into the address book
insertRecord(){
 if fileExists; then
 read -p "Enter ID: " ID # -p for printing the string on same 
line before taking user input
 read -p "Enter Name: " name
 # Email validation
 while true; do
 read -p "Enter Email: " email 
 if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@gmail\.com$ ]]; then
 break
 else
 echo "Invalid email. Please enter a valid '@gmail.com' 
email."
 fi
 done
 # Phone number validation
 while true; do
 read -p "Enter Phone Number: " phone
 if [[ "$phone" =~ ^[0-9]{10}$ ]]; then
 break
 else
 echo "Invalid phone number. Please enter a 10-digit phone 
number."
 fi
 done
 read -p "Enter Address: " address
 # Blood group validation
 while true; do
 read -p "Enter Blood Group (A+, A-, B+, B-, AB+, AB-, O+, O-
): " blood_group
 if [[ "$blood_group" =~ ^(A\+|A-|B\+|B-|AB\+|AB-|O\+|O-)$ ]]; 
then
 break
 else
 echo "Invalid blood group. Please enter one of the valid 
blood groups."
 fi
 done
 # Age validation
 while true; do
 read -p "Enter Age: " age
 if [[ "$age" -gt 0 ]]; then
 break
 else
 echo "Invalid age. Please enter a valid age between 0 and 
150."
 fi
 done
 # Weight validation
 while true; do
 read -p "Enter Weight (in kg): " weight
 if [[ "$weight" -gt 0 ]]; then
 break
 else
 echo "Invalid weight. Please enter a valid weight."
 fi
 done
 # Gender validation
 while true; do
 read -p "Enter Gender (M/F/O): " gender
 if [[ "$gender" =~ ^(M|F|O)$ ]]; then
 break
 else
 echo "Invalid gender. Please enter 'M' for Male, 'F' for 
Female, or 'O' for Other."
 fi
 done
 echo "| $ID | $name | $email | $phone | $address | $blood_group | 
$age | $weight | $gender |" >> Address_Book.txt
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
# Function to delete a record from the address book
deleteRecord(){
 if fileExists; then
 read -p "Enter name: " name
 if grep -iq "| $name |" Address_Book.txt; then # -i to make 
the search insensitive -q for returning true or false 
 grep -iv "| $name |" Address_Book.txt > temp.txt && mv 
temp.txt Address_Book.txt # -v for searching and returning non-matching 
lines
 echo "Record Deleted"
 else
 echo "Record Not Found"
 fi
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
# Function to search for a record in the address book
searchRecord(){
 if fileExists; then
 read -p "Enter Name: " name
 if grep -iq "| $name |" Address_Book.txt; then
 grep -i "| $name |" Address_Book.txt
 else
 echo "Record Not Found"
 fi
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
# Function to update a record in the address book
updateRecord(){
 if fileExists; then
 read -p "Enter Name: " name
 if grep -iq "| $name |" Address_Book.txt; then
 grep -iv "| $name |" Address_Book.txt > temp.txt && mv 
temp.txt Address_Book.txt
 read -p "Enter ID: " ID
 while true; do
 echo "Select the field to update:"
 echo "1. Email"
 echo "2. Phone Number"
 echo "3. Address"
 echo "4. Age"
 echo "5. Weight"
 
 echo "6. Done"
 read -p "Enter choice: " choice
 case $choice in
 1)
 while true; do
 read -p "Enter Email: " email
 if [[ "$email" =~ ^[a-zA-Z0-9._%+-
]+@gmail\.com$ ]]; then
 break
 else
 echo "Invalid email. Please enter a valid 
'@gmail.com' email."
 fi
 done
 ;;
 2)
 while true; do
 read -p "Enter Phone Number: " phone
 if [[ "$phone" =~ ^[0-9]{10}$ ]]; then
 break
 else
 echo "Invalid phone number. Please enter 
a 10-digit phone number."
 fi
 done
 ;;
 3)
 read -p "Enter Address: " address
 ;;
 
 4)
 while true; do
 read -p "Enter Age: " age
 if [[ "$age" -gt 0 ]]; then
 break
 else
 echo "Invalid age. Please enter a valid 
age between 0 and 150."
 fi
 done
 ;;
 5)
 while true; do
 read -p "Enter Weight (in kg): " weight
 if [[ "$weight" -gt 0 ]]; then
 break
 else
 echo "Invalid weight. Please enter a 
valid weight."
 fi
 done
 ;;
 
 6)
 break
 ;;
 *)
 echo "Invalid choice. Please select a valid 
field."
 ;;
 esac
 done
 echo "| $ID | $name | $email | $phone | $address | 
$blood_group | $age | $weight | $gender |" >> Address_Book.txt
 echo "Record Updated"
 else
 echo "Record Not Found"
 fi
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
sortRecords() {
 if fileExists; then
 if [ -s Address_Book.txt ]; then
 echo "ID | Name | Email | Phone Number | Address | Blood 
Group | Age | Weight | Gender |"
 (head -n 1 Address_Book.txt && tail -n +2 Address_Book.txt | 
sort -t'|' -k1,1) > sorted_db.txt
 cat sorted_db.txt
 mv sorted_db.txt Address_Book.txt
 else
 echo "Address Book is Empty"
 fi
 else
 echo "Address Book is Not Created. First Create Address Book"
 fi
}
main() {
 while true; do
 echo -e "\nWelcome to Address Book\n"
 echo "1. Create Address Book"
 echo "2. View Address Book"
 echo "3. Insert Record"
 echo "4. Delete Record"
 echo "5. Search Record"
 echo "6. Update Record"
 echo "7. Sort Records"
 echo -e "8. Exit\n"
 read -p "Enter Choice: " choice
 case $choice in
 1)
 createAddressBook
 ;;
 2)
 viewAddressBook
 ;;
 3)
 insertRecord
 ;;
 4)
 deleteRecord
 ;;
 5)
 searchRecord
 ;;
 6)
 updateRecord
 ;;
 7)
 sortRecords
 ;;
 8)
 exit
 ;;
 *)
 echo "Invalid Choice"
 ;;
 esac
 done
}
# Run the main function
main
