
import Label from 'components/common/Label';
import styled from 'styled-components';

const LabelsItemInput = () => {
  const title = 'document';
  const labelColor = '#007AFF';
  const textColor = 'white';

  return (
    <StyledLabelsItemInput>
      <LabelsInputDisplay>
        <Label {...{ title, labelColor, textColor }} />
      </LabelsInputDisplay>
      <LabelsInputs>
   
      </LabelsInputs>
    </StyledLabelsItemInput>
  );
};

export default LabelsItemInput;

const StyledLabelsItemInput = styled.div`
  display: flex;
`;

const LabelsInputs = styled.div`
  ${({ theme }) => theme.style.flexColumn}
  width: 75%;
`;

const LabelsInputDisplay = styled.div`
  width: 25%;
`;
