--Loading Data into SQL queries

Select *
From Portfolio_Project..Nashville_Housing

--Changing the Sales Date
Select SalesDataConverted, CONVERT(Date,SaleDate)
From Portfolio_Project..Nashville_Housing

Update Nashville_Housing
Set SaleDate =  CONVERT(Date,SaleDate) 

ALTER TABLE Nashville_Housing
Add SalesDataConverted Date;

Update Nashville_Housing
Set SalesDataConverted =  CONVERT(Date,SaleDate) 

--Populate property Address data
Select *
From Portfolio_Project..Nashville_Housing
--Where PropertyAddress is Null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From Portfolio_Project..Nashville_Housing a
JOIN Portfolio_Project..Nashville_Housing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is Null

Update a
SET propertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From Portfolio_Project..Nashville_Housing a
JOIN Portfolio_Project..Nashville_Housing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is Null

--Breaking up the Address 

Select PropertyAddress
From Portfolio_Project..Nashville_Housing
--Where PropertyAddress is Null
order by ParcelID

SELECT
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) - 1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) + 1,LEN(PropertyAddress)) as City
FROM Portfolio_Project..Nashville_Housing

ALTER TABLE Nashville_Housing
Add PropertySplitAdress NVARCHAR(255);

Update Portfolio_Project..Nashville_Housing
Set PropertySplitAdress = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) - 1)

ALTER TABLE Nashville_Housing
Add City NVARCHAR(255);

Update Portfolio_Project..Nashville_Housing
Set City = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) + 1,LEN(PropertyAddress))

SELECT *
FROM Portfolio_Project..Nashville_Housing


SELECT OwnerAddress
FROM Portfolio_Project..Nashville_Housing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM Portfolio_Project..Nashville_Housing


ALTER TABLE Portfolio_Project..Nashville_Housing
Add OwnerSplitAddress NVARCHAR(255);

Update Portfolio_Project..Nashville_Housing
Set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE Portfolio_Project..Nashville_Housing
Add OwnerSplitCity NVARCHAR(255);

Update Portfolio_Project..Nashville_Housing
Set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)


ALTER TABLE Portfolio_Project..Nashville_Housing
Add OwnerSplitState NVARCHAR(255);

Update Portfolio_Project..Nashville_Housing
Set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)



-- Change Y and N to Yes and No in "Sold as Vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From Portfolio_Project..Nashville_Housing
Group By SoldAsVacant
Order By 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   Else SoldAsVacant
	   End
From Portfolio_Project..Nashville_Housing

Update Portfolio_Project..Nashville_Housing
Set SoldAsVacant =  CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   Else SoldAsVacant
	   End




