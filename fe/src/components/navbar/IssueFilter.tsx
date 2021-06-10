import {
  Button,
  Divider,
  FormControl,
  FormControlLabel,
  FormLabel,
  Menu,
  MenuItem,
  Radio,
  RadioGroup,
} from '@material-ui/core';
import PopupState, { bindMenu, bindTrigger } from 'material-ui-popup-state';
import { useState } from 'react';
import styled from 'styled-components';

const IssueFilter = () => {
  const [value, setValue] = useState('female');

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setValue((event.target as HTMLInputElement).value);
  };

  return (
    <>
      <PopupState variant="popover" popupId="demo-popup-menu">
        {(popupState) => (
          <>
            <FilterButton
              variant="contained"
              color="primary"
              {...bindTrigger(popupState)}
            >
              필터
            </FilterButton>
            <CustomMenu {...bindMenu(popupState)}>
              <FormControl component="fieldset">
                <FormLabel component="legend">이슈 필터</FormLabel>
                <RadioGroup
                  aria-label="gender"
                  name="gender1"
                  value={value}
                  onChange={handleChange}
                >
                  <MenuItem onClick={popupState.close}>
                    <CustomFormControlLabel
                      value="opened"
                      control={<Radio />}
                      label="열린 이슈"
                      labelPlacement="start"
                    />
                  </MenuItem>
                  <Divider />
                  <MenuItem onClick={popupState.close}>
                    <CustomFormControlLabel
                      value="written"
                      control={<Radio />}
                      label="내가 작성한 이슈"
                      labelPlacement="start"
                    />
                  </MenuItem>
                  <Divider />
                  <MenuItem onClick={popupState.close}>
                    <CustomFormControlLabel
                      value="assigned"
                      control={<Radio />}
                      label="나에게 할당된 이슈"
                      labelPlacement="start"
                    />
                  </MenuItem>
                  <Divider />
                  <MenuItem onClick={popupState.close}>
                    <CustomFormControlLabel
                      value="commented"
                      control={<Radio />}
                      label="내가 댓글을 남긴 이슈"
                      labelPlacement="start"
                    />
                  </MenuItem>
                  <Divider />
                  <MenuItem onClick={popupState.close}>
                    <CustomFormControlLabel
                      value="closed"
                      control={<Radio />}
                      label="닫힌 이슈"
                      labelPlacement="start"
                    />
                  </MenuItem>
                </RadioGroup>
              </FormControl>
            </CustomMenu>
          </>
        )}
      </PopupState>
    </>
  );
};

const FilterButton = styled(Button)`
  background-color: ${({ theme }) => theme.color.grayscale.background};
  color: ${({ theme }) => theme.color.grayscale.label};
  font-weight: ${({ theme }) => theme.fontWeight.bold2};
  border: 1px solid ${({ theme }) => theme.color.grayscale.line};
  box-shadow: none;
`;

const CustomMenu = styled(Menu)`
  margin-top: 10.5rem;
`;

const CustomFormControlLabel = styled(FormControlLabel)`
  width: 100%;
  justify-content: space-between;
`;

export default IssueFilter;
