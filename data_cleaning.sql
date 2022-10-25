/* Cleaning data*/
SELECT * FROM datacleaningproyecto.data_cleaning;

-- Buscando los valores en blanco de "Property Address" para hacerlos NULL // Turning blank values into NULL values

SELECT PropertyAddress, UNIQUEID
FROM datacleaningproyecto.data_cleaning
WHERE PropertyAddress is null
;
UPDATE
    data_cleaning
SET
    PropertyAddress = CASE PropertyAddress WHEN '' THEN NULL ELSE PropertyAddress END;

-- Estableciendo nueva direccion de PropertyAddress // Stablishing new PropertyAddress

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, coalesce(a.PropertyAddress, b.PropertyAddress) as New_address
FROM datacleaningproyecto.data_cleaning a 
JOIN datacleaningproyecto.data_cleaning b
 on	a.ParcelID = b.parcelID
 AND a.UniqueID != b.UniqueID
WHERE a.PropertyAddress is null;
UPDATE
    data_cleaning
SET
    PropertyAddress = CASE PropertyAddress WHEN '' THEN NULL ELSE PropertyAddress END;

-- Reemplazando los NULLS // Replacing NULL values  

UPDATE data_cleaning a
JOIN datacleaningproyecto.data_cleaning b
 on	a.ParcelID = b.parcelID
 AND a.UniqueID != b.UniqueID
SET a.PropertyAddress = coalesce(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress is null; 

-- Separando la columna "Property Address" en tres columnas distintas: Dirección, Ciudad, Estado // Separating "PropertyAddress" column into
-- 3 different columns: Address, City, State 

SELECT PropertyAddress 
FROM datacleaningproyecto.data_cleaning;

SELECT 
SUBSTRING(PropertyAddress, 1, locate(",", PropertyAddress)-1) as Address, 
SUBSTRING(PropertyAddress, locate(",", PropertyAddress)+1, length(PropertyAddress)) as Address 
FROM datacleaningproyecto.data_cleaning;

-- Agregando las columnas correspondientes y actualizandolas//Adding the corresponding columns and updating them

ALTER table data_cleaning
ADD PropertySplitAddress nvarchar(255);

UPDATE data_cleaning
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, locate(",", PropertyAddress)-1);

ALTER table data_cleaning
ADD PropertySplitCity nvarchar(255);

UPDATE data_cleaning
SET PropertySPlitCity = SUBSTRING(PropertyAddress, locate(",", PropertyAddress)+1, length(PropertyAddress));


-- Separando la OwnerAddress con otro método (SUBSTRING_INDEX)//Using another method to separate OwnerAddress column

SELECT OwnerAddress
FROM datacleaningproyecto.data_cleaning;

SELECT 
SUBSTRING_INDEX(OwnerAddress, ',', 1),
SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1),
SUBSTRING_INDEX(OwnerAddress, ',', -1)
FROM datacleaningproyecto.data_cleaning;

ALTER table data_cleaning
ADD OwnerSplitAddress nvarchar(255);
UPDATE data_cleaning
SET OwnerSplitAddress = SUBSTRING_INDEX(OwnerAddress, ',', 1);


ALTER table data_cleaning
ADD OwnerSPlitCity nvarchar(255);
UPDATE data_cleaning
SET OwnerSPlitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1);


ALTER table data_cleaning
ADD PropertySplitState nvarchar(255);
UPDATE data_cleaning
SET PropertySplitState = SUBSTRING_INDEX(OwnerAddress, ',', -1);


-- En la columna SoldAsVacant hay 4 valores (Yes, No, Y, N). Los quiero reducir a Yes y No: // Reducing values (YES, NO, Y, N) to YES and NO

SELECT 
Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM datacleaningproyecto.data_cleaning
GROUP BY SoldAsVacant
ORDER BY 2; 

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END     
FROM datacleaningproyecto.data_cleaning;

UPDATE data_cleaning
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	 WHEN SoldAsVacant = 'N' THEN 'No'
     ELSE SoldAsVacant
     END;    
     

-- Ahora voy a reomver los valores duplicados en base a las columnas cuyos valores deberían ser únicos// 
-- Now im going to be removing duplicates based on the columns that should have unique values

WITH RowNumCTE as (
SELECT UniqueID ,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID, 
				 PropertyAddress, 
				 SalePrice,	
                 saledate, 
                 LegalReference  
					ORDER BY 
                    UniqueID
                    ) as rownum
FROM data_cleaning)
DELETE dc
FROM data_cleaning dc INNER JOIN rownumcte r ON dc.UniqueID = r.UniqueID
WHERE rownum > 1;


WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID, 
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
					ORDER BY
					UniqueID
					) row_num
             
FROM datacleaningproyecto.data_cleaning
)
SELECT * FROM RowNumCTE
WHERE row_num > 1;

-- 0 rows returned. Great! 

-- Eliminando columnas no usadas // Rmoving some unused columns

SELECT * FROM datacleaningproyecto.data_cleaning;

ALTER TABLE datacleaningproyecto.data_cleaning
-- DROP COLUMN OwnerAddress,
-- DROP COLUMN PropertyAddress,
-- DROP COLUMN SaleDate











    
    