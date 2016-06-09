DELIMITER //

DROP PROCEDURE IF EXISTS sanatize_earnings_release //

/*
Description: Update any garbase release time to 'Time Not Supplied'
Example: CALL sanatize_earnings_release;
*/
CREATE PROCEDURE sanatize_earnings_release()
BEGIN
	SET SQL_SAFE_UPDATES = 0;

	UPDATE earnings_release dest,
	(SELECT * FROM earnings_release
	WHERE release_time != 'Before Market Open'
		AND release_time != 'After Market Close' 
		AND release_time != 'Time Not Supplied'
		AND release_time NOT LIKE '% ET') src
	SET dest.release_time = 'Time Not Supplied'
	WHERE src.earnings_id = dest.earnings_id;

	SET SQL_SAFE_UPDATES = 1;
END //
DELIMITER ;