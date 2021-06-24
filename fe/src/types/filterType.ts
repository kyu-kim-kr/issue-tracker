export type FilterItemType = {
  id: number;
  title: string;
  imgurl?: string | null;
  description?: string;
  labelColor?: string;
};

export type FilterListType = {
  filterList: FilterItemType[];
  filterTitle: string;
  onClose:  () => void;
  clickHandler?: (e: React.MouseEvent<HTMLLIElement>) => void;
  value?: number[];
};  

export type FilterItemPropsType = {
  filterItem: FilterItemType;
  isEnd: boolean;
  onClose:  () => void;
  clickHandler?: (e: React.MouseEvent<HTMLLIElement>) => void;
  value?: number[];
};

export type FilterPropsType = {
  filterType: FilterSelectorType;
  isPlus?: boolean;
  clickHandler?: (e: React.MouseEvent<HTMLLIElement>) => void;
  value?: number[];
};

export type FilterSelectorType = 'milestoneList' | 'labelList' | 'assigneeList';
//| 'authorList'| 'assigneeList';
