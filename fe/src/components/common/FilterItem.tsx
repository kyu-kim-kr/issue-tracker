import { Divider, MenuItem, Checkbox } from '@material-ui/core';
import { MouseEvent } from 'react';
import styled from 'styled-components';
import { FilterItemPropsType } from '../../types/filterType';
import { ReactComponent as CheckOff } from 'icons/check-off-circle.svg';
import { ReactComponent as CheckOn } from 'icons/check-on-circle.svg';
import AuthorAvatar from './AuthorAvatar';
const FilterItem = ({ filterItem, isEnd }: FilterItemPropsType) => {
  const handleClick = (e: MouseEvent<HTMLLIElement>) => {
    console.log(filterItem.id);
  };

  return (
    <>
      <StyledFilterItem onClick={handleClick}>
        <StyledSpan>
          {filterItem.labelColor ? (
            <StyledColor colorCode={filterItem.labelColor} />
          ) : null}
          {filterItem.imgurl ? (
            <AuthorAvatar size="S" profileImg={filterItem.imgurl} />
          ) : null}
          <span>{filterItem.title || filterItem.description}</span>
        </StyledSpan>
        <Checkbox icon={<CheckOff />} checkedIcon={<CheckOn />} />
      </StyledFilterItem>
      {isEnd ? null : <Divider />}
    </>
  );
};
const StyledSpan = styled.span`
  ${({ theme }) => theme.style.flexAlignItemsCenter}
  font-size: ${({ theme }) => theme.fontSize.S};
  span{
    margin-left: 0.5rem;
  }
`;
const StyledFilterItem = styled(MenuItem)`
  ${({ theme }) => theme.style.flexSpaceBetween}
  width: 15rem;
  background-color: white;
`;
const StyledColor = styled.div<{ colorCode: string }>`
  width: 1rem;
  height: 1rem;
  border-radius: 50%;
  background-color: ${({ colorCode }) => colorCode};
  border: 1px solid ${({ theme }) => theme.color.grayscale.line};
`;
export default FilterItem;
// ${({ colorCode }) => colorCode}
