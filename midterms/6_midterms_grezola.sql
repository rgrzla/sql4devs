DECLARE @x INT = 1, @y INT;

WHILE @x < 11
BEGIN
    SET @y = 1
	WHILE @y < 11
		BEGIN
		PRINT CONVERT(VARCHAR, @x) + ' * ' + CONVERT(VARCHAR, @y) + ' = ' + CONVERT(VARCHAR, @x * @y);
		SET @y = @y + 1;
	END;
   SET @x = @x + 1;
END;

------------