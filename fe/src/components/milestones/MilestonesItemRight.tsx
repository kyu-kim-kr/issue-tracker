import styled from 'styled-components';
import { MilestoneBarProps } from 'types/issueType';
import MilestoneBar from './MilestoneBar';

const MilestonesItemRight = ({
  openedIssueCount,
  closedIssueCount,
}: MilestoneBarProps) => {
  return (
    <StyledDiv>
      <MilestoneBar {...{ openedIssueCount, closedIssueCount }} />
    </StyledDiv>
  );
};

export default MilestonesItemRight;

const StyledDiv = styled.div`
  width: 20rem;
`;
