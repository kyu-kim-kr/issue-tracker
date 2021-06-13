import styled from 'styled-components';
import IssueItem from './IssueItem';
import IssuesHeader from './IssuesHeader';

const Issues = () => {
  return (
    <StyledIssues>
      <StyledIssuesHeader>
        <IssuesHeader />
      </StyledIssuesHeader>
      <StyledIssuesContent>
        <IssueItem
          isOpen={true}
          title="이슈 제목"
          labeList={[{ title: '레이블 이름', colorCode: '#4444',textColor: 'white' }]}
          issueNumber={1}
          author={{ name: 'eamon', profileImg: undefined }}
          createdTime={'2021-06-21 12:11'}
          milestoneTitle={'마스터즈 코스'}
        />
      </StyledIssuesContent>
    </StyledIssues>
  );
};

export default Issues;

const StyledIssues = styled.div`
  ${({ theme }) => theme.style.flexColum}
  box-sizing: border-box;
`;

const StyledIssuesHeader = styled.div`
  ${({ theme }) => theme.style.upperWrapper}
  width: 100%;
  box-sizing: border-box;
`;

const StyledIssuesContent = styled.div`
  ${({ theme }) => theme.style.lowerWrapper}
  box-sizing: border-box;
`;
