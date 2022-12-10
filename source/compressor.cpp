#include "compressor.hpp"

Compressor::Compressor(QObject* parent) : QObject(parent)
{
    actionType.process = new QProcess(this);
    {
        connect(actionType.process, SIGNAL(started()), this, SLOT(processStarted()));
        connect(actionType.process, SIGNAL(readyReadStandardOutput()),this,SLOT(readyReadStandardOutput()));
        connect(actionType.process, SIGNAL(finished(int)), this, SLOT(encodingFinished()));
    }
}

Compressor::~Compressor()
{
}

bool Compressor::busy() const
{
    return actionType.busy;
}

void Compressor::setBusy(bool busy)
{
    if (busy != actionType.busy) {
        actionType.busy = busy;
    }
    emit busyChanged(actionType.busy);
}

bool Compressor::run() const
{
    return actionType.run;
}

void Compressor::setRun(bool run)
{
    if (run != actionType.run) {
        actionType.run = run;
    }
    emit runChanged(actionType.run);
}

QString Compressor::input() const
{
    return actionType.inputString;
}

void Compressor::setInput(QString input)
{
    actionType.inputString = input;
    emit inputChanged(actionType.inputString);
}

QString Compressor::output() const
{
    return actionType.outputString;
}

void Compressor::setOutput(QString output)
{
    if (output != actionType.outputString) {
        actionType.outputString = output;
    }
    emit outputChanged(actionType.outputString);
}

void Compressor::processStarted()
{
    setBusy(true);
}

void Compressor::readyReadStandardOutput()
{
    actionType.outputString.append(actionType.process->readAllStandardOutput());
    this->setOutput(actionType.outputString);
}

void Compressor::encodingFinished()
{
    setBusy(false);
}

void Compressor::compress(qint8 value)
{
    actionType.process->setReadChannel(QProcess::StandardOutput);
    actionType.process->setProcessChannelMode(QProcess::MergedChannels);
    QStringList arguments;
    arguments << "-i"
              << input()
              << "-vcodec"
              << "libx264"
              << "-crf"
              << QString::number(value)
              << output();
    auto program = QCoreApplication::applicationDirPath() + "/" + QString("ffmpeg");
    actionType.process->start(program, arguments);
}
