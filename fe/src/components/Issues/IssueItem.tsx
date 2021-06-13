import { Checkbox } from '@material-ui/core';
import { ReactComponent as Open } from 'icons/openIssue.svg';
import { ReactComponent as Close } from 'icons/closeIssue.svg';
import { ReactComponent as Milestone } from 'icons/openMilestone.svg';
import styled from 'styled-components';
import { IssueItemType } from 'types/issueType';

const IssueItem = ({
  isOpen,
  title,
  labeList,
  issueNumber,
  author,
  createdTime,
  milestoneTitle,
}: IssueItemType) => {
  return (
    <StyledIssueItem>
      <IssueItemLeft>
        <div>
          <Checkbox color="primary" /> 
          <span>
            <OpenSvg />
            {title}
          </span>
        </div>
        <IssueSubtitle>
          #{issueNumber} {createdTime} <MilestoneSvg/> {milestoneTitle}
        </IssueSubtitle>
      </IssueItemLeft>
      <IssueItemRight>


      </IssueItemRight>
    </StyledIssueItem>
  );
};

export default IssueItem;

const StyledIssueItem = styled.li`
  ${({ theme }) => theme.style.flexSpaceBetween}
`;
const IssueItemLeft = styled.div`
  ${({ theme }) => theme.style.flexColum}
`;
const IssueItemRight = styled.div``;

const OpenSvg = styled(Open)`
  path {
    stroke: inherit;
  }
  margin-right: 0.2rem;
`;


const MilestoneSvg = styled(Milestone)`
  path {
    stroke: inherit;
  }
  margin-right: 0.2rem;
`;


const IssueSubtitle = styled.span``;
