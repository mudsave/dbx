--[[SocialServerConstant

    Func:Save the constant of socialServer
    Author: Caesar
    Update: 16.12.16 Done
]]

CurWorldID = 0

--玩家状态
PlayerState = {
    Ask     =   1,--正在申请
    Already =   2,--已经是好友
}

--黑名单状态
BlackListState = {
    Not     =   0,--不在黑名单
    Screen  =   1,--在屏蔽名单中
    Enemy   =   2,--在仇人名单中
}

friendInfoFunc = {
	showInChat  = 1,
	showInCheck = 2,
}

--离线消息种类
OfflineMsgKind = {

    FriendAsk   = 1,
    GroupAsk    = 2,
    FriendChat  = 3,
    GroupChat   = 4

}

--更新操作代码
UpdateCode = {

    Delete      = 0,
    Add         = 1,
    Create      = 2,
    Update      = 3,
}

UpdateWorldServerDataCode = {

    ExitFaction         = 1,
    JoinFaction         = 2,
    CreateFaction       = 3,
    ContributeFaction   = 4,
}

--帮派地位
FactionPosition = {

    Leader = 1,
    AssociateLeader = 2,
    Elder = 3,
    Guard = 4,
    Director = 5,
    Member = 6

}

--帮派管理资金
FactionMgrMoney = {

    3000,
    12000,
    27000,
    48000,
    60750

}

--帮派最大成员数
FactionMaxMemberCount = {

    20,
    40,
    60,
    80,
    100

}

--系统信息盒参数
MsgboxParams = {

    MsgType = {
        OnlineMsg  = 1,
        OfflineMsg = 2,     
    },
    MsgKind = {
        MsgKind_FriendAsk                   = 1,
        MsgKind_GroupInvite                 = 2,
        MsgKind_DeleteRecentContactPlayer   = 3,
        MsgKind_DeleteFriend                = 4,
        MsgKind_DeleteGroup                 = 5,
        MsgKind_DeleteBlacklistPlayer       = 6,
        MsgKind_FactionInvite               = 9,
        MsgKind_LeaderAssignment            = 10,
    }

}

AlreadyLoadData = {

    FactionData = false,
    FriendOfflineData = false,
    GroupOfflineData = false,

}

TransportionKind = {

    FlyFlag                 = 1,
    WorldMapTransportion    = 2,
    NormalTransportion      = 3,

}

NotifyKind = {

    NormalNotify            = 1,
    PlayerIsInFaction       = 2,
    CancelFactionApply      = 3,
    ContributeFaction       = 4,
    FriendNotify            = 5,
    FactionNotify           = 6,
    GroupNotify             = 7,
    FactionChatChannel      = 8,

}

PlayerOnlineState = {

    Online = 1,
    Offline = 2,
    
}

FactionApplyState = {

    Apply = 1,
    Cancel = 2,

}

FriendMsgTextKeyTable = {

    FailtoAddFriend = 1,
    AlreadyInBlackList = 2,
    PlayerIsNotExist    =3,
    PlayerIsNotOnline   = 4,

}

FactionMsgTextKeyTable = {

    AlreadyInBlackList      = 1,
    AlreadyHaveFaction      = 2,
    FactionMembersIsEnough  = 3,
    FactionNameExist        = 4,
    MsgSendSucceed          = 5,
    LevelIsNotEnough        = 6,
    MoneyIsNotEnough        = 7,
    FactionMemberJoin       = 9,
    FireFactionMember       = 10,
    BeFiredInFaction        = 11,
    DismissFaction          = 12,
}

GroupMsgTextKeyTable = {

    AlreadyInGroup  = 1,
    GroupIsNotExist = 2,

}

BroadCastMsgGroupID = {

    Group_TreasureEvent        = {
        EventID = 20,
        DigTreasure_RealeaseMonster     = 5106,
        DigTreasure_GetGoldItem         = 5107,
        DigTreasure_GetGreenItem        = 5108,
        DigTreasure_GetPlentyTickets    = 5109,
        
    },
    Group_RemakeEquipment      = {
        EventID = 24,
        RemakeEquip_AddPointToTwelve    = 1,
        RemakeEquip_AddPointToSixth     = 2,
    
    },
    Group_Ride                 = {
        EventID = 15,
        UpgradeMounts_AddPointToSix     = 4,
        UpgradeMounts_AddPointToSeven   = 5,
        UpgradeMounts_AddPointToEight   = 6,
        UpgradeMounts_AddPointToNine    = 7,
        SummonMounts_SummonSixGrade     = 8,
    
    },
	Group_DekaronSchool                 = {
        EventID = 26,
        ActivityPreOpening				= 1,
        ActivityOpening					= 2,
		ActivityClose					= 3,
    },
    Group_SkyFallBox                    = {
        EventID = 31,
        ActivityOpening                 = 1,
        ActivityClose                   = 2,
    },
}
