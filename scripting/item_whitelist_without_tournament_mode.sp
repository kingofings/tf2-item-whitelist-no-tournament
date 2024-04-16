#include <sourcescramble>

#pragma newdecls required
#pragma semicolon 1

public Plugin myinfo =
{
	name = "[TF2] Item Whitelist without Tournament mode",
	author = "kingo",
	description = "Allows to use the tournament whitelist even when tournament mode is disabled",
	version = "0.0.1",
	url = "kingo.tf"
};


public void OnPluginStart()
{
	GameData gameConf = new GameData("tf2.tournamentwhitelist");
	if (!gameConf)SetFailState("Could not parse gamedata file tf2.tournamentwhitelist.txt!");

	MemoryPatch bypassTournamentRestriction = MemoryPatch.CreateFromConf(gameConf, "CEconItemSystem::ReloadWhitelist()::BypassTournamentRestriction");

	if (!bypassTournamentRestriction.Validate())SetFailState("Failed to verify Patch CEconItemSystem::ReloadWhitelist()::BypassTournamentRestriction");
	else if (bypassTournamentRestriction.Enable())LogMessage("Enabled static Patch CEconItemSystem::ReloadWhitelist()::BypassTournamentRestriction");

	MemoryPatch CTFPlayerBypassTournamentRestriction = MemoryPatch.CreateFromConf(gameConf, "CTFPlayer::GetLoadoutItem()::BypassTournamentRestriction");

	if (!CTFPlayerBypassTournamentRestriction.Validate())SetFailState("Failed to verify Patch CTFPlayer::GetLoadoutItem()::BypassTournamentRestriction");
	else if (CTFPlayerBypassTournamentRestriction.Enable())LogMessage("Enabled static Patch CTFPlayer::GetLoadoutItem()::BypassTournamentRestriction");

	delete gameConf;
}