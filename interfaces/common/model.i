////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Project:  Embedded Machine Learning Library (EMLL)
//  File:     model.i (interfaces)
//  Authors:  Chuck Jacobs
//
////////////////////////////////////////////////////////////////////////////////////////////////////

%{
#define SWIG_FILE_WITH_INIT
#include "Node.h"
#include "ModelGraph.h"
#include "Port.h"
#include "InputPort.h"
#include "OutputPort.h"
#include "PortElements.h"
#include "InputNode.h"
#include "OutputNode.h"
%}

%rename (ModelGraph) model::Model;

%nodefaultctor model::NodeIterator;
%nodefaultctor model::Node;
%nodefaultctor model::Port;
%nodefaultctor model::OutputPortBase;
%nodefaultctor model::InputPortBase;

%include "Port.h"
%include "OutputPort.h"
%include "PortElements.h"
%include "Node.h"
%include "ModelGraph.h"
%include "InputPort.h"
%include "InputNode.h"
%include "OutputNode.h"

%template (DoubleOutputPort) model::OutputPort<double>;
%template (BoolOutputPort) model::OutputPort<bool>;
%template () model::PortElements<double>;
%template () model::PortElements<bool>;

#ifndef SWIGXML
%template (NodeVector) std::vector<model::Node*>;
%template (ConstNodeVector) std::vector<const model::Node*>;
%template (PortVector) std::vector<model::Port*>;
%template (InputPortVector) std::vector<model::InputPortBase*>;
%template (OutputPortVector) std::vector<model::OutputPortBase*>;

%template (DoubleInputNode) model::InputNode<double>;
%template (BoolInputNode) model::InputNode<bool>;
%template (DoubleOutputNode) model::OutputNode<double>;

%template (DoubleInputNodeVector) std::vector<const model::InputNode<double>*>;
%template (DoubleOutputNodeVector) std::vector<const model::OutputNode<double>*>;

#endif

%ignore model::Model::ComputeOutput;

%extend model::Model 
{
    // get input nodes
    std::vector<const model::InputNode<double>*> GetDoubleInputNodes()
    {
        return $self->GetNodesByType<model::InputNode<double>>();
    }

    // get output nodes
    std::vector<const model::OutputNode<double>*> GetDoubleOutputNodes()
    {
        return $self->GetNodesByType<model::OutputNode<double>>();
    }

    // compute output
    std::vector<double> ComputeDoubleOutput(const OutputPort<double>& outputPort) const
    {
        return $self->ComputeOutput(outputPort);
    }
}
