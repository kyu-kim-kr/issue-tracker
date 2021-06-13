import { TextField } from '@material-ui/core';
import AuthorAvatar from 'components/common/AuthorAvatar';
import styled from 'styled-components';

const NewIssueLeft = () => {
  return (
    <>
      <AuthorAvatar size="L" name="eamon" />
      <CustomTextField label="제목" variant="filled" />
    </>
  );
};

export default NewIssueLeft;

const CustomTextField = styled(TextField)`
  width: 60%;
  margin-left: 1rem;
  .MuiInputLabel-filled {
    margin-left: 1rem;
  }

  .MuiFilledInput-root {
    border-radius: 14px;
    padding: 0 1rem;
  }
  .MuiFilledInput-underline::before {
    border-bottom: 0px solid;
  }
  .MuiFilledInput-underline::after {
    border-bottom: 0px solid;
  }
  label.MuiFormLabel-root.Mui-focused {
    color: ${({ theme }) => theme.color.grayscale.label};
  }
  .MuiInputLabel-filled.MuiInputLabel-shrink {
    transform: translate(12px, 10px) scale(0.6);
  }
`;
