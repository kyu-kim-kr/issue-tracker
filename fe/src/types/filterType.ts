export type FilterItemType = {
  description: string;
  imgurl?: string | null;
  labelColor?: string;
};

export type FilterListType = {
  filterList: FilterItemType[];
};

export type FilterItemPropsType = {
  filterItem: FilterItemType;
  isEnd: boolean;
};
