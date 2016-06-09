DECLARE @@Id INT

SELECT @@Id = MAX(Id) + 10 FROM ROLE

INSERT INTO Role
SELECT @@Id,
		@Application
		@Name,
		@Description
