﻿SELECT APPLICATION Value, app.NAME Text
FROM USER_PROFILE userProfile INNER JOIN dbo.APPLICATION app ON userProfile.APPLICATION = app.ID
WHERE NETWORK_ID = @NetworkId