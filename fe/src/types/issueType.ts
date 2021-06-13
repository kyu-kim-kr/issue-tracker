export type IssueItemType = {
  isOpen: boolean;
  title: string;
  labeList: labelType[];
  issueNumber: number;
  author: authorType;
  createdTime: number;
  milestoneTitle: string;
};

export type labelType = {
  title: string;
  colorCode: string;
};

export type authorType = {
  name: string;
  profileImg: string;
};
