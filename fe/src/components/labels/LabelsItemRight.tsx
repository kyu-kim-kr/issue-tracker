import { Button } from '@material-ui/core';
import styled from 'styled-components';
import { ReactComponent as EditSvg } from 'icons/edit.svg';
import { ReactComponent as DeleteSvg } from 'icons/delete.svg';
const LabelsItemRight = () => {
  return (
    <StlyedLabelsItemRight>
      <EditButton>
        <EditIcon /> 편집
      </EditButton>
      <DeleteButton>
        <DeleteIcon /> 삭제
      </DeleteButton>
    </StlyedLabelsItemRight>
  );
};

export default LabelsItemRight;

const StlyedLabelsItemRight = styled.div`
  display: flex;
`;

const EditButton = styled(Button)``;

const EditIcon = styled(EditSvg)``;

const DeleteButton = styled(Button)`
  color: ${({ theme }) => theme.color.red};
`;

const DeleteIcon = styled(DeleteSvg)``;
