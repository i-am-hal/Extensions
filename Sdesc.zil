"S D E S C - Extension

(Credit to Jesse McGrew, and Hendrik Åsman)"

<PROPDEF SDESCFCN <>>

<DEFMAC PRINTD ("ARGS" OBJ)
    <FORM NEW-PRINTD !.OBJ>>

<ROUTINE NEW-PRINTD (OBJ "AUX" FUNC)
    <COND
        (<SET FUNC <GETP .OBJ ,P?SDESCFCN>>
            <APPLY .FUNC>)
        
        (ELSE
            <PRINTD!-SOME-NEW-OBLIST-NAME .OBJ>)>>

