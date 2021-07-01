import { Box } from '@material-ui/core';
import { useState } from 'react';
import styled from 'styled-components';
import CreateButton from 'components/buttons/CreateButton';
import CommentTextarea from 'components/common/CommentTextarea';
import { ReactComponent as PlusSvg } from 'icons/plus.svg';

const CommentEdit = ({ defaultValue }: { defaultValue: string }) => {
  const [commentValue, setCommentValue] = useState<string>(defaultValue);
  const handleChange = (e: React.ChangeEvent<HTMLTextAreaElement>) =>
    setCommentValue(e.target.value);

  const editCommentHandler = () => {
    const token = localStorage.getItem('jwt');
    // (async function () {

    // })();
  };

  return (
    <NewCommentWrapper display="flex">
      <NewCommentInputArea>
        <CommentTextarea value={commentValue} handleChange={handleChange} />
      </NewCommentInputArea>

      <NewCommentButtonArea>
        <CreateButton onClick={editCommentHandler} icon={<PlusIcon />}>
          코멘트 편집
        </CreateButton>
      </NewCommentButtonArea>
    </NewCommentWrapper>
  );
};

export default CommentEdit;

const NewCommentWrapper = styled(Box)`
  margin-left: 1rem;
  display: flex;
  flex-direction: column;
  width: 100%;
`;

const NewCommentInputArea = styled.div`
  display: flex;
  margin-bottom: 1rem;
`;

const NewCommentButtonArea = styled.div`
  display: flex;
  justify-content: flex-end;
`;

const PlusIcon = styled(PlusSvg)`
  path {
    stroke: ${({ theme }) => theme.color.grayscale.offWhite};
  }
`;
