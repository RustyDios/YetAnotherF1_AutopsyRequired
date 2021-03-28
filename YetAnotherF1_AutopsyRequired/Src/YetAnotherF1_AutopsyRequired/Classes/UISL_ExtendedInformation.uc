//-----------------------------------------------------------
//	Class:	UIScreenListener_ExtendedInformation
//	Authors: Iridar, RustyDios, Kdm2k6 and MrNiceUK
//	
//	Created some time before	19/01/21	00:00
//	Last Edited by RustyDios	28/01/21    00:18
//
//	Purpose: To nullify the Extended Information enemy tooltips 
//	until the 'autopsy' is done, making YAF1 the sole source of the info
//
//  ALSO includes the perk/buffs from Show More Buff Details and BaseGame
//
//-----------------------------------------------------------

class UISL_ExtendedInformation extends UIScreenListener;

var int WatchIndexHover;

var string EnemyToolTipTargetPath;

event OnInit(UIScreen Screen)
{
    local UITacticalHUD		HUD;

    HUD = UITacticalHUD(Screen);

    if (HUD != none)
    {
        /*		-- thankyou kdm2k6 !!
        *  Associate a variable with a callback such that the callback will be issued when the variable changes. The variable
        *  specified by kWatchName must be a field of kWatchVarOwner. Supported types are all primitive types plus structs and arrays.
        *  
        *  Return value is a handle that can be used to enable / disable the watch variable
        */
        //native function int RegisterWatchVariable( Object kWatchVarOwner, name kWatchName, 
		//							       Object kCallbackOwner, delegate<WatchVariable.WatchVariableCallback> CallbackFn, optional int ArrayIndex = -1);
        WatchIndexHover = Screen.WorldInfo.MyWatchVariableMgr.RegisterWatchVariable( HUD.m_kEnemyTargets, 'm_iCurrentHover', self, OnHoverChangedFn, -1);

        `LOG("SET WorldInfo For HUD: WatchIndex:" @WatchIndexHover @": Current Hover :" @HUD.m_kEnemyTargets.m_iCurrentHover, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired_WI');

        OnInit_LogAllToolTips(HUD);

        EnemyToolTipTargetPath = string(HUD.m_kEnemyTargets.MCPath);

        `LOG("EnemyToolTipTargetPath:" @EnemyToolTipTargetPath, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

        CheckAndConfirm_TooltipElements(HUD, true);

        OnHoverChangedFn();
    }
}

// This event is triggered after a screen receives focus
event OnReceiveFocus(UIScreen Screen){}

// This event is triggered after a screen loses focus
event OnLoseFocus(UIScreen Screen){}

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen)
{
    local UITacticalHUD		HUD;

    HUD = UITacticalHUD(Screen);

    if (HUD != none)
    {
        //AT END OF TACTICAL PLAY (TACTICAL HUD REMOVED) ENSURE WE REMOVE THE WATCH ORDERS!!
        Screen.WorldInfo.MyWatchVariableMgr.EnableDisableWatchVariable(WatchIndexHover, true);
        Screen.WorldInfo.MyWatchVariableMgr.UnRegisterWatchVariable( WatchIndexHover );
    }

}

// This function is triggered when the mouse moves over the HUD Target icons - magic by Kdm2k6 !
simulated function OnHoverChangedFn()
{
    local LWTuple               Tuple;
	local XGUnit                ActiveUnit;
	local XComGameState_Unit    UnitState;
    local UITacticalHUD		    HUD;

    //CANT PASS THE HUD INTO THE DELEGATE SO WE SIMPLY GET IT AGAIN
    HUD = `PRES.GetTacticalHUD();
   	
    `LOG("========== STARTING YAF1AR TOOLTIP CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

    if (HUD != none)
    {
	    `LOG("HOVER INDEX CHANGED:" @HUD.m_kEnemyTargets.m_iCurrentHover, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

        //WE HAVE A HUD AND WE'VE CHANGED AN ICON, GET THE CORRESPONDING UNIT & UNITSTATE
		ActiveUnit = XGUnit(HUD.m_kEnemyTargets.GetEnemyAtIcon(HUD.m_kEnemyTargets.m_iCurrentHover));
        if( ActiveUnit != none )
        {
            `LOG("ACTIVE UNIT FOUND",class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

            UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ActiveUnit.ObjectID));

            //IF UNIT EXISTS AND NOT A FRINDLY UNIT, IE IS ENEMY
            if (UnitState != none)
            {
                if (!UnitState.IsFriendlyToLocalPlayer() )
                {
                    `LOG("UNIT STATE PULLED IN :" @UnitState.GetFullName(), class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

                    //CHECK UNIT STATE AGAINST AUTOPSY CONDITIONAL LOGIC AND BLOCK TOOLTIPS OR NOT
                    if (class'X2EventListener_AutopsyRequired'.static.IsEnemyInfoBlocked(Tuple, UnitState))
                    {
                        CheckAndConfirm_TooltipElements(HUD, true); //BLOCK
                        `LOG("UNIT STATE, TOOLTIPS BLOCKED", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
                    }
                    else
                    {
                        CheckAndConfirm_TooltipElements(HUD, false); //normal behaviour, SHOW
                        `LOG("UNIT STATE, TOOLTIPS SHOWN", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
                    }
                }
                else
                {
                    //UNITSTATE WAS FRIENDLY, SHOW
                    `LOG("UNIT STATE WAS FRIENDLY:" @UnitState.GetFullName(), class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
                }
            }
            else
            {
                //FAILED TO FIND A UNITSTATE, SHOW
                `LOG("NO UNIT STATE FOR ACTIVE UNIT",class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
            }
        }
        else
        {
            //FAILED TO FIND A UNITSTATE, SHOW
            `LOG("NO ACTIVE UNIT FOR INDEX",class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
        }
    }

   	`LOG("========== FINISHED YAF1AR TOOLTIP CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}

//triggered on init to log all tooltips
simulated function OnInit_LogAllToolTips(UITacticalHUD HUD)
{
    local UITooltipMgr          Mgr;
	local int					i;
	local string				ClassPath, TargetLog;

    //KAREN !! CALL THE MANAGER ... 
    Mgr = HUD.Movie.Pres.m_kTooltipMgr;
    TargetLog = "TARGETPATH:";

    for (i = Mgr.Tooltips.Length - 1; i >= 0; i--)
    {
        //FOR EACH TOOLTIP RECORD ITS PATHNAME, INDEX AND ID
        ClassPath = PathName(Mgr.Tooltips[i].Class);

        `LOG("INIT TOOLTIP CLASS FOUND:" @ClassPath, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
        
        if (i < 10)
        {
            TargetLog = " TARGETPATH:";
        }

        `LOG("INDEX/ID :" @i @TargetLog @Mgr.Tooltips[i].TargetPath, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
        
    }
}

//triggered post check to HIDE tooltips
simulated function CheckAndConfirm_TooltipElements(UITacticalHUD HUD, optional bool bHideTips)
{
    local UITooltipMgr          Mgr;
	local int					i;
	local string				ClassPath;

    //KAREN !! CALL THE MANAGER ... 
    Mgr = HUD.Movie.Pres.m_kTooltipMgr;

    for (i = Mgr.Tooltips.Length - 1; i >= 0; i--)
    {
		if (Mgr.Tooltips[i].TargetPath == EnemyToolTipTargetPath)   //ensure this is an enemy tooltip
		{
            ClassPath = PathName(Mgr.Tooltips[i].Class);

            //EI ENEMY STATS        EI ENEMY ABILITY        EI ALL BUFFS/DEBUFFS [BECAUSE IT ALSO INCLUDES PASSIVES >:( ]
                //MRNICE SAYS FOR BUFFSTOOLTIPS:    bShowPassive = false, makes enemy passives not show but buffs/debuffs still show
                //  1=FRIENDLY BUFF        //  2=FRIENDLY DEBUFF        //  3=ENEMY PASSIVES        //  4=ENEMY BUFF        //  5=ENEMY DEBUFF

            //SHOW MORE BUFF DETAILS PERKS                  SHOW MORE BUFF DETAILS BUFFS/DEBUFFS    
            //  AND FINALLY THE BASEGAME VARIENTS - RECALL THIS WILL NEVER BE FOR FRIENDLIES, ONLY NON-AUTOPSIED ENEMIES

            //||  ClassPath ~= "ShowMoreBuffDetails.UI_TacHUD_PerkToolTipNew"     REMOVED FROM FILTER WAS CAUSING ISSUES - SOLDIER PERKS TOOLTIP
            //||  ClassPath ~= "XComGame.UITacticalHUD_PerkTooltip"               REMOVED FROM FILTER WAS CAUSING ISSUES - SOLDIER PERKS TOOLTIP

            if (ClassPath ~= "WOTC_DisplayHitChance.UITacticalHUD_EnemyTooltip_HitChance"
                || ClassPath ~= "WOTC_DisplayHitChance.UITacticalHUD_EnemyAbilityTooltip"
                || ClassPath ~= "WOTC_DisplayHitChance.UITacticalHUD_BuffsTooltip_HitChance"
                || ClassPath ~= "ShowMoreBuffDetails.UI_TacHUD_BuffToolTipNew"
                || ClassPath ~= "XComGame.UITacticalHUD_EnemyTooltip"
                || ClassPath ~= "XComGame.UITacticalHUD_BuffsTooltip"
                )
            {    
                //FOR EACH TOOLTIP MATCHING THE FILTERS ABOVE, DECIDE ITS FATE
                //`LOG("FILTERED TOOLTIP INDEX/ID :" @i, class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

                if (class'X2EventListener_AutopsyRequired'.default.bAlwaysBlockEITooltips)
                {
                    Mgr.RemoveTooltipByID(Mgr.Tooltips[i].ID);  //remove tooltips
                }
                else if (bHideTips && class'X2EventListener_AutopsyRequired'.default.bHideEITooltips)
                {
                    Mgr.DeactivateTooltip(Mgr.Tooltips[i], false);     //hide tooltips
                }
                else
                {
                    //DO NOTHING - WE DONT WANT TO ALTER THE TOOLTIP AT ALL
                    //ENABLING THE BELOW CAUSES 'INSTANT' TOOLTIPS WITH NO ANIMATION
                    //Mgr.ActivateTooltip(Mgr.Tooltips[i]);     //show tooltips
                }
            }
        }
    }
}

/*
[WOTC_DisplayHitChance.MCM_Defaults]
; Change this to show Enemies ToolTips when hovering mouse over them
ES_TOOLTIP = true
*/
