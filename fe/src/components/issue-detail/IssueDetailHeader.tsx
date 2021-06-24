import styled from 'styled-components';
import IssueStateSign from './IssueStateSign';
import { ReactComponent as EditSvg } from 'icons/edit.svg';
import { ReactComponent as CloseSvg } from 'icons/closeIssue.svg';
import { ReactComponent as OpenSvg } from 'icons/openIssue.svg';
import { Button } from '@material-ui/core';

const temp = {
  issueNumber: 2,
  isOpen: false,
  author: 'Eamon',
};
const { issueNumber, isOpen, author } = temp;

const IssueDetailHeader = () => (
  <Header>
    <IssueDetailHeaderLeft>
      <Title>
        <div className="title">FE 이슈트래커 디자인 시스템 구현</div>
        <div className="issue-number">#{issueNumber}</div>
      </Title>
      <Caption>
        <IssueStateSign isOpen={isOpen} />

        <div className="issue-description">
          {isOpen
            ? `이 이슈가 20분 전에 ${author}님에 의해 열렸습니다`
            : `이 이슈가 20분 전에 ${author}님에 의해 닫혔습니다`}
        </div>
        <div className="divider">•</div>
        <div className="comment-count">코멘트 1개</div>
      </Caption>
    </IssueDetailHeaderLeft>

    <IssueDetailHeaderRight>
      <EditButton>
        <EditIcon />
        <span>제목 편집</span>
      </EditButton>

      {isOpen ? (
        <IssueOpenCloseButton>
          <CloseIcon />
          <span>이슈 닫기</span>
        </IssueOpenCloseButton>
      ) : (
        <IssueOpenCloseButton>
          <OpenIcon />
          <span>다시 열기</span>
        </IssueOpenCloseButton>
      )}
    </IssueDetailHeaderRight>
  </Header>
);

const Header = styled.header`
  display: flex;
  justify-content: space-between;
`;

const IssueDetailHeaderLeft = styled.div``;

const Title = styled.div`
  display: flex;
  margin-bottom: 1rem;

  .title {
    color: ${({ theme }) => theme.color.grayscale.titleActive};
    font-size: ${({ theme }) => theme.fontSize.XXL};
  }

  .issue-number {
    margin-left: 1rem;
    color: ${({ theme }) => theme.color.grayscale.label};
    font-size: ${({ theme }) => theme.fontSize.XXL};
  }
`;

const Caption = styled.div`
  display: flex;
  align-items: center;

  .issue-description,
  .divider,
  .comment-count {
    color: ${({ theme }) => theme.color.grayscale.body};
    font-size: ${({ theme }) => theme.fontSize.L};
  }

  .divider {
    margin: 0 0.2rem;
  }

  .issue-description {
    margin-left: 0.5rem;
  }
`;

const IssueDetailHeaderRight = styled.div`
  display: flex;
`;

const EditButton = styled(Button)`
  width: 7.5rem;
  height: 2.5rem;
  border: 2px solid ${({ theme }) => theme.color.blue};
  border-radius: ${({ theme }) => theme.border.radius.S};
  color: ${({ theme }) => theme.color.blue};
  background-color: ${({ theme }) => theme.color.grayscale.offWhite};
  font-size: ${({ theme }) => theme.fontSize.S};
  font-weight: ${({ theme }) => theme.fontWeight.bold2};
  display: flex;
  align-items: center;

  span {
    margin-left: 0.2rem;
  }
`;

const EditIcon = styled(EditSvg)`
  path {
    stroke: ${({ theme }) => theme.color.blue};
  }
`;

const IssueOpenCloseButton = styled(Button)`
  width: 7.5rem;
  height: 2.5rem;
  border: 2px solid ${({ theme }) => theme.color.blue};
  border-radius: ${({ theme }) => theme.border.radius.S};
  color: ${({ theme }) => theme.color.blue};
  background-color: ${({ theme }) => theme.color.grayscale.offWhite};
  font-size: ${({ theme }) => theme.fontSize.S};
  font-weight: ${({ theme }) => theme.fontWeight.bold2};
  display: flex;
  align-items: center;
  margin-left: 0.5rem;

  span {
    margin-left: 0.2rem;
  }
`;

const CloseIcon = styled(CloseSvg)`
  path {
    stroke: ${({ theme }) => theme.color.blue};
  }
`;

const OpenIcon = styled(OpenSvg)`
  path {
    stroke: ${({ theme }) => theme.color.blue};
  }
`;

export default IssueDetailHeader;