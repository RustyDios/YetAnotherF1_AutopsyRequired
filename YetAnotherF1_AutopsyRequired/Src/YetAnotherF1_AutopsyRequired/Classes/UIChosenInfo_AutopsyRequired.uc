//---------------------------------------------------------------------------------------
//  FILE:    UIChosenInfo_AutopsyRequired.uc
//  AUTHOR:  RUSTYDIOS
//	
//	Created     25/01/21	00:00
//	Last Edit   26/01/21	05:00
//
//  PURPOSE: This file controls the Chosen Info screen on strategy layer
//
//---------------------------------------------------------------------------------------
class UIChosenInfo_AutopsyRequired extends UIChosenInfo;

var localized string ChosenInfo_EncountersLabel_Required;       //= "ENCOUNTERS / REQUIRED FOR INFO REVEAL:"
var localized string ChosenInfo_XComAwarenessLabel_Required;	//= "INFO REVEAL AT:"
var localized string ChosenInfo_XComAwarenessLabel_Completed;   //= "INFO REVEALED!"

var string strReason;

//parent vars of interest
//var localized string ChosenInfo_EncountersLabel                   = "ENCOUNTERS:"
//var localized string ChosenInfo_XComAwarenessLabel                = "HUNT PROGRESS:"
//var localized string ChosenInfo_UnknownChosenTraitName;			= "UNKNOWN"
//var localized string ChosenInfo_UnknownChosenTraitDescription;	= "-- ?? -- ?? --"

//var string UnknownChosenTraitIcon;	=	"img:///UILibrary_PerkIcons.UIPerk_unknown"

//var array<XComGameState_AdventChosen> AllActiveChosen;
//var XComGameState_AdventChosen SelectedChosen;

//----------------------------------------------------------------------------
// MEMBERS

public function AS_SetInfoPanel(string Icon,
	string ChosenType,
	string ChosenName,
	string ChosenNickname,
	int	   EncountersValue,
	int	   SoldiersKilledValue,
	int	   SoldiersCapturedValue,
	int	   ChosenAwarenessMeterValue,
	string ChosenAwarenessMeterText,
	int    XComAwarenessMeterValue,
	string XComAwarenessMeterText)
{
   	`LOG("========== STARTING YAF1AR CHOSEN INFO CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("SetInfoPanel");
	MC.QueueString(Icon);
	MC.QueueString(Caps(ChosenType));
	MC.QueueString(ChosenName);
	MC.QueueString(class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(ChosenNickname));
	
    //if it's blocked and encounters are not met show required
    if (class'X2EventListener_AutopsyRequired'.default.NumChosenEncountersRequired > EncountersValue
        && class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason)
        )
    {							//"\n $ENCOUNTERS / REQUIRED FOR INFO REVEAL: \n X/Y "
        MC.QueueString(ChosenInfo_EncountersLabel_Required);
	    MC.QueueString(string(EncountersValue) @"/" @class'X2EventListener_AutopsyRequired'.default.NumChosenEncountersRequired);
    }
    else    //else , not blocked, show normal
    {
        MC.QueueString(ChosenInfo_EncountersLabel);
	    MC.QueueString(string(EncountersValue));
    }

	MC.QueueString(ChosenInfo_KillsLabel);
	MC.QueueString(string(SoldiersKilledValue));
	MC.QueueString(ChosenInfo_CapturesLabel);
	MC.QueueString(string(SoldiersCapturedValue));
	MC.QueueString(ChosenInfo_ChosenAwarenessLabel);
	MC.QueueNumber(ChosenAwarenessMeterValue);
	MC.QueueString(ChosenAwarenessMeterText);

    //if it's blocked and influence is not met show required
    if (int(class'X2EventListener_AutopsyRequired'.default.RivalFactionInfluenceRequired) > XComAwarenessMeterValue
        && class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason)
        )
    {
        //              "\n $HUNT PROGRESS: @X $\n $INFO REVEAL AT: @Y"
	    MC.QueueString("\n" $ChosenInfo_XComAwarenessLabel @XComAwarenessMeterValue $"\n" $ChosenInfo_XComAwarenessLabel_Required @int(class'X2EventListener_AutopsyRequired'.default.RivalFactionInfluenceRequired));
    }
    else    //else , not blocked, show 'info revealed'
    {
    	MC.QueueString("\n" $ChosenInfo_XComAwarenessLabel $"\n" $ChosenInfo_XComAwarenessLabel_Completed);
    }

	MC.QueueNumber(XComAwarenessMeterValue);
	MC.QueueString(XComAwarenessMeterText);
	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN INFO CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
} 

/*
//DECIDED AGAINST OBSFUCATING THESE
function AS_SetWeaknessFaction(string FactionType, string FactionName)
{
	MC.BeginFunctionOp("SetWeaknessFaction");
	MC.QueueString(ChosenInfo_FactionLabel);
	MC.QueueString(Caps(FactionType));
	MC.QueueString(Caps(FactionName));
	MC.EndOp();
}

function AS_SetWeaknessFactionIcon(StackedUIIconData IconInfo)
{
	local int i;

	MC.BeginFunctionOp("SetWeaknessFactionIcon");
	MC.QueueBoolean(IconInfo.bInvert);
	for( i = 0; i < IconInfo.Images.Length; i++ )
	{
		MC.QueueString("img:///" $ IconInfo.Images[i]);
	}

	MC.EndOp();
}
*/

function AS_SetStrengthData(int Index, string ImagePath, string ItemName, string ItemDesc)
{
   	`LOG("========== STARTING YAF1AR CHOSEN STR CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

    MC.BeginFunctionOp("SetStrengthData");
    MC.QueueNumber(Index);

    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        MC.QueueString(UnknownChosenTraitIcon);
        MC.QueueString(ChosenInfo_UnknownChosenTraitName);
        MC.QueueString(ChosenInfo_UnknownChosenTraitDescription);
	}
    else	//base game behaviour
    {
        MC.QueueString(ImagePath);
        MC.QueueString(ItemName);
        MC.QueueString(ItemDesc);
    }

	MC.QueueBoolean(true);
	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN STR CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}

function AS_SetWeaknessData(int Index, string IconPath, string ItemName, string ItemDesc)
{
   	`LOG("========== STARTING YAF1AR CHOSEN WKN CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("SetWeaknessData");
	MC.QueueNumber(Index);
	
    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        MC.QueueString(UnknownChosenTraitIcon);
        MC.QueueString(ChosenInfo_UnknownChosenTraitName);
        MC.QueueString(ChosenInfo_UnknownChosenTraitDescription);
	}
    else	//base game behaviour
    {
        MC.QueueString(IconPath);
        MC.QueueString(ItemName);
        MC.QueueString(ItemDesc);
    }

	MC.QueueBoolean(true);
	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN WKN CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}
