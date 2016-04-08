//
//  HJTeamModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamModel.h"

@implementation HJTeamModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.teamName = @"青年志愿者协会";
        self.teamIcon = @"team_img01";
        self.title = @"中国青年志愿者协会";
        self.content = @"中国青年志愿者协会成立于1994年12月5日，是由志愿从事社会公益事业与社会保障事业的各界青年组成的全国性社会团体 ，是中国共产主义青年团中央指导下的，由依法成立的省、自治区、直辖市青年志愿者组织和全国性的专业、行业青年志愿者组织和个人自愿结成的全国性的非营利性社会组织，是全国青联团体会员，联合国国际志愿服务协调委员会（CCIVS）联席会员组织。";
        self.followNums = @"358";
        self.relatedTopics = @"42";
        self.registerTime = @"15.11";
    }
    return self;
}
@end
