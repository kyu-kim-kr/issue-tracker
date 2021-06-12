import { Divider, MenuItem, Checkbox } from '@material-ui/core';
import { forwardRef, Ref } from 'react';
import styled from 'styled-components';
import { FilterItemPropsType } from '../../types/filterType';

const FilterItem = ({  filterItem, isEnd }: FilterItemPropsType ,ref:Ref<HTMLElement>) => {
  return (
    <>
      <StyledFilterItem>
        <span>{filterItem.description}</span>
        <Checkbox />
      </StyledFilterItem>
      {isEnd? null : <Divider />}
    </>
  );
};

const StyledFilterItem = styled(MenuItem)`
  ${({ theme }) => theme.style.flexSpaceBetween}
  width: 12rem;
  background-color: white;
`;

export default forwardRef(FilterItem);
