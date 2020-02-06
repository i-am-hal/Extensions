"Game - Scoring"

"Actions"

<SETG EXTRA-GAME-VERBS '(NOTIFY-OFF NOTIFY-ON SCORE)>


"Action - Disabling Score Update Notification"

<SYNTAX NOTIFY OFF OBJECT (FIND KLUDGEBIT) = V-NOTIFY-OFF>

<ROUTINE V-NOTIFY-OFF ()
    <TELL "Score notification off." CR>
    <SETG SCORE-UPDATE-NOTIFICATION-ON <>>
>


"Action - Enabling Score Update Notification"

<SYNTAX NOTIFY ON OBJECT (FIND KLUDGEBIT) = V-NOTIFY-ON>
<SYNTAX NOTIFY = V-NOTIFY-ON>

<ROUTINE V-NOTIFY-ON ()
    <TELL "Score notification on." CR>
    <SETG SCORE-UPDATE-NOTIFICATION-ON T>
>


"Action - On Demand Score Notification"

<SYNTAX SCORE = V-SCORE>

<ROUTINE V-SCORE ()
    <TELL "You have so far scored " N ,SCORE ", ">
    <TELL "out of a possible " N ,MAX-SCORE ", ">
    <TELL "in " N ,MOVES " turns." CR>
>


"Activities"

"Activity - Score Update Notification"

<GLOBAL PREV-SCORE 0>
<GLOBAL SCORE-UPDATE-NOTIFICATION-ON T>

<ROUTINE NOTIFY-IF-SCORE-UPDATED ("AUX" UPDATE)
    <SET UPDATE <- ,SCORE ,PREV-SCORE>>
    <COND (<AND .UPDATE <NOT ,FINISH-CODE>>
        <COND (,SCORE-UPDATE-NOTIFICATION-ON
            <TELL CR "[Your score has gone">
            <COND (<G? .UPDATE 0>
                <TELL " up">)
            (ELSE
                <SET UPDATE <- .UPDATE>>
                <TELL " down">)>
            <TELL " by " N .UPDATE " point">
            <COND (<NOT <1? .UPDATE>>
                <TELL "s">)>
            <TELL ".]" CR>)>
        <SETG PREV-SCORE ,SCORE>)>
>


"Activity - Final Score Notification"

<GLOBAL MAX-SCORE 0>

<ROUTINE PRINT-FINAL-SCORE ()
    <TELL "In that game you scored " N ,SCORE ", ">
    <TELL "out of a possible " N ,MAX-SCORE ", ">
    <TELL "in " N ,MOVES " turns." CR>
>

<BIND ((REDEFINE T))
    <ROUTINE PRINT-GAME-OVER ()
        <CRLF>
        <PRINT-FINAL-SCORE>
    >
>


"Activity - Finishing the Game"

<GLOBAL FINISH-CODE 0>

<ROUTINE FINISH-IF-CODE-SET ()
    <COND (,FINISH-CODE
        <COND (<1? ,FINISH-CODE>
            <PRINT-WIN-MESSAGE>)
        (ELSE
            <PRINT-LOSE-MESSAGE>)>
    )>
>

<ROUTINE PRINT-WIN-MESSAGE ()
    <JIGS-UP "    *** You have won ***">
>

<ROUTINE PRINT-LOSE-MESSAGE ()
    <JIGS-UP "    *** You have lost ***">
>
