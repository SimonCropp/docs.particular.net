startcode CreateSubscriptionTableTextSql


IF EXISTS (
    SELECT *
    FROM {1}.sys.objects
    WHERE object_id = OBJECT_ID(N'{0}')
        AND type in (N'U'))
RETURN

EXEC sp_getapplock @Resource = '{0}_lock', @LockMode = 'Exclusive'

IF EXISTS (
    SELECT *
    FROM {1}.sys.objects
    WHERE object_id = OBJECT_ID(N'{0}')
        AND type in (N'U'))
BEGIN
    EXEC sp_releaseapplock @Resource = '{0}_lock'
    RETURN
END

BEGIN TRY
    CREATE TABLE {0} (
        QueueAddress NVARCHAR(200) NOT NULL,
        Endpoint NVARCHAR(200) NOT NULL,
        Topic NVARCHAR(200) NOT NULL,
        PRIMARY KEY CLUSTERED
        (
            Endpoint,
            Topic
        )
    )
END TRY
BEGIN CATCH
    EXEC sp_releaseapplock @Resource = '{0}_lock';
    THROW;
END CATCH;

EXEC sp_releaseapplock @Resource = '{0}_lock'
endcode
